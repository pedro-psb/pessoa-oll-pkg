# Toolbox Module
The module handles the loading of tools and presets of tools.

## This modules contain:
- **Definitions**
	> note-names, drum-styles and glyphs.
	- They should have a clear API, so the importer knows what names
	will be avaliable and where they can be used.
	 -Additionally, they can be importer with options.
- **Presets**
	> bundling the include of a set of definitions.
	- Presets can be defined in a file presets.ily. The module
	provides a loadPreset function.
	- For now, it won't handle options.
	- eg: If one chooses the "manden preset I", the module loads
	the corresponding drumDef and NoteNames. "manden preset II"
	could load some different drumDefs or NoteNames. It should also load
	some special glyphs, like the muffling noteHead.

## API
loadDrumStyles style
