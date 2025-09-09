# gnome-thumbnailer.yazi
A yazi plugin to preview extensions supported by [`gnome-*-thumbnailer`](https://gitlab.gnome.org/GNOME/gnome-epub-thumbnailer)

<img width="672" height="400" alt="preview" src="https://github.com/user-attachments/assets/228c84a0-aeb9-48e4-bd55-5c994f80c0de" />


## Extensions
* .mobi `(application/mobipocket-ebook)`
* .epub `(application/epub+zip)`

## Installation
* ### Yazi Package Manager  
```sh
ya pkg add elvyria/gnome-thumbnailer
```
* ### Git
```sh
git clone 'https://github.com/Elvyria/gnome-thumbnailer.yazi' "${XDG_CONFIG_HOME}/yazi/plugins/gnome-thumbnailer.yazi"
```

## Usage

* #### MIME
```toml
[plugin]
prepend_previewers = [
	{ mime = "application/epub+zip",         run = "gnome-thumbnailer" },
	{ mime = "application/mobipocket-ebook", run = "gnome-thumbnailer" },
]
```
* #### Extension
```toml
prepend_previewers = [
    { name = "*.epub", run = "gnome-thumbnailer" },
    { name = "*.mobi", run = "gnome-thumbnailer" },
]
```
