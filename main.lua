local M = {}

function M:peek(job)
	local start, cache = os.clock(), ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err = self:preload(job)
	if not ok or err then
		return ya.preview_widget(job, err)
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

	local _, err = ya.image_show(cache, job.area)
	ya.preview_widget(job, err)
end

function M:seek() end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	local supported = {
		["application/epub+zip"] = "epub",
		["application/mobipocket-ebook"] = "mobi",
	}

	local format = supported[job.mime]

	if not format then
		for _, ext in pairs(supported) do
			if ext == job.file.ext then
				format = job.file.ext
				break
			end
		end
	end

	if not format then
		return false, Err("File format is not supported by the gnome thumbnailer")
	end

	local status, err = Command("gnome-"..format.."-thumbnailer"):arg({
		"-s", rt.preview.max_width,
		tostring(job.file.url),
		tostring(cache)
	}):status()

	if not status then
		return true, Err("Failed to start `gnome-"..format.."-thumbnailer`, error: %s", err)
	elseif not status.success then
		return false, Err("`gnome-"..format.."-thumbnailer` exited with error code: %s", status.code)
	else
		return true
	end
end

return M
