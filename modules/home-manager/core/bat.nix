{ config, pkgs, lib, username, ... }:

{ 
  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.packages = with pkgs; [
      bat-extras.batman
    ];

    programs.bat = {
      enable = true;

      themes.catppuccin-macchiato = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
          <dict>
            <key>name</key>
            <string>Catppuccin</string>
            <key>settings</key>
            <array>
              <dict>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#cad3f5</string>
                  <key>background</key>
                  <string>#24273a</string>
                  <key>caret</key>
                  <string>#b8c0e0</string>
                  <key>invisibles</key>
                  <string>#a5adcb</string>
                  <key>gutterForeground</key>
                  <string>#939ab7</string>
                  <key>gutterForegroundHighlight</key>
                  <string>#a6da95</string>
                  <key>lineHighlight</key>
                  <string>#5b6078</string>
                  <key>selection</key>
                  <string>#6e738d</string>
                  <key>selectionBorder</key>
                  <string>#24273a</string>
                  <key>activeGuide</key>
                  <string>#f5a97f</string>
                  <key>findHighlightForeground</key>
                  <string>#1e2030</string>
                  <key>findHighlight</key>
                  <string>#eed49f</string>
                  <key>bracketsForeground</key>
                  <string>#939ab7</string>
                  <key>bracketContentsForeground</key>
                  <string>#939ab7</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Comment</string>
                <key>scope</key>
                <string>comment</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#6e738d</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>String</string>
                <key>scope</key>
                <string>string</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#a6da95</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>String regex</string>
                <key>scope</key>
                <string>string.regexp</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5a97f</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Number</string>
                <key>scope</key>
                <string>constant.numeric</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5a97f</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Boolean</string>
                <key>scope</key>
                <string>constant.language.boolean</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5a97f</string>
                  <key>fontStyle</key>
                  <string>bold italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Built-in constant</string>
                <key>scope</key>
                <string>constant.language</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#b7bdf8</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Built-in function</string>
                <key>scope</key>
                <string>support.function.builtin</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5a97f</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>User-defined constant</string>
                <key>scope</key>
                <string>variable.other.constant</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5a97f</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Variable</string>
                <key>scope</key>
                <string>variable</string>
                <key>settings</key>
                <dict></dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Keyword</string>
                <key>scope</key>
                <string>keyword</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Conditional/loop</string>
                <key>scope</key>
                <string>keyword.control.loop, keyword.control.conditional, keyword.control.c++</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#c6a0f6</string>
                  <key>fontStyle</key>
                  <string>bold</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Return</string>
                <key>scope</key>
                <string>keyword.control.return, keyword.control.flow.return</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5bde6</string>
                  <key>fontStyle</key>
                  <string>bold</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Exception</string>
                <key>scope</key>
                <string>support.type.exception</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5a97f</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Operator</string>
                <key>scope</key>
                <string>keyword.operator, punctuation.accessor</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#91d7e3</string>
                  <key>fontStyle</key>
                  <string>bold</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Punctuation separator</string>
                <key>scope</key>
                <string>punctuation.separator</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Punctuation terminator</string>
                <key>scope</key>
                <string>punctuation.terminator</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Punctuation bracket</string>
                <key>scope</key>
                <string>punctuation.section</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#939ab7</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Include</string>
                <key>scope</key>
                <string>keyword.control.import.include</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Storage</string>
                <key>scope</key>
                <string>storage</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Storage type</string>
                <key>scope</key>
                <string>storage.type</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#eed49f</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Storage modifier</string>
                <key>scope</key>
                <string>storage.modifier</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Storage type namespace</string>
                <key>scope</key>
                <string>entity.name.namespace, meta.path</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f4dbd6</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Storage type class</string>
                <key>scope</key>
                <string>storage.type.class</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f4dbd6</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Label</string>
                <key>scope</key>
                <string>entity.name.label</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8aadf4</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Keyword class</string>
                <key>scope</key>
                <string>keyword.declaration.class</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Class name</string>
                <key>scope</key>
                <string>entity.name.class, meta.toc-list.full-identifier</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#91d7e3</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Inherited class</string>
                <key>scope</key>
                <string>entity.other.inherited-class</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#91d7e3</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Function name</string>
                <key>scope</key>
                <string>entity.name.function, variable.function</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8aadf4</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Function macro</string>
                <key>scope</key>
                <string>entity.name.function.preprocessor</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Macro directive - ifdef</string>
                <key>scope</key>
                <string>keyword.control.import</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Constructor</string>
                <key>scope</key>
                <string>entity.name.function.constructor, entity.name.function.destructor</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#b7bdf8</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Function argument</string>
                <key>scope</key>
                <string>variable.parameter.function</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f4dbd6</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Function declaration</string>
                <key>scope</key>
                <string>keyword.declaration.function</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ee99a0</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Library function</string>
                <key>scope</key>
                <string>support.function</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#91d7e3</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Library constant</string>
                <key>scope</key>
                <string>support.constant</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8aadf4</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Library class/type</string>
                <key>scope</key>
                <string>support.type, support.class</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8aadf4</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Library variable</string>
                <key>scope</key>
                <string>support.other.variable</string>
                <key>settings</key>
                <dict>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Variable function</string>
                <key>scope</key>
                <string>variable.function</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8aadf4</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Variable parameter</string>
                <key>scope</key>
                <string>variable.parameter</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f4dbd6</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Variable other</string>
                <key>scope</key>
                <string>variable.other</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#cad3f5</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Variable field</string>
                <key>scope</key>
                <string>variable.other.member</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f4dbd6</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Variable language</string>
                <key>scope</key>
                <string>variable.language</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Tag name</string>
                <key>scope</key>
                <string>entity.name.tag</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5a97f</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Tag attribute</string>
                <key>scope</key>
                <string>entity.other.attribute-name</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#c6a0f6</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Tag delimiter</string>
                <key>scope</key>
                <string>punctuation.definition.tag</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ee99a0</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Markdown URL</string>
                <key>scope</key>
                <string>markup.underline.link.markdown</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f4dbd6</string>
                  <key>fontStyle</key>
                  <string>italic underline</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Markdown reference</string>
                <key>scope</key>
                <string>meta.link.inline.description</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#b7bdf8</string>
                  <key>fontStyle</key>
                  <string>bold</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Markdown literal</string>
                <key>scope</key>
                <string>comment.block.markdown, meta.code-fence, markup.raw.code-fence, markup.raw.inline</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Markdown title</string>
                <key>scope</key>
                <string>punctuation.definition.heading, entity.name.section</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8aadf4</string>
                  <key>fontStyle</key>
                  <string>bold</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Markdown emphasis</string>
                <key>scope</key>
                <string>markup.italic</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ee99a0</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Markdown strong</string>
                <key>scope</key>
                <string>markup.bold</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ee99a0</string>
                  <key>fontStyle</key>
                  <string>bold</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Escape</string>
                <key>scope</key>
                <string>constant.character.escape</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5bde6</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Bash built-in function</string>
                <key>scope</key>
                <string>source.shell.bash meta.function.shell meta.compound.shell meta.function-call.identifier.shell</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f5bde6</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Bash parameter</string>
                <key>scope</key>
                <string>variable.language.shell</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Lua field</string>
                <key>scope</key>
                <string>source.lua meta.function.lua meta.block.lua meta.mapping.value.lua meta.mapping.key.lua string.unquoted.key.lua</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#b7bdf8</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Lua constructor</string>
                <key>scope</key>
                <string>source.lua meta.function.lua meta.block.lua meta.mapping.key.lua string.unquoted.key.lua</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f0c6c6</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Java constant</string>
                <key>scope</key>
                <string>entity.name.constant.java</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>CSS property</string>
                <key>scope</key>
                <string>support.type.property-name.css</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#f0c6c6</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>CSS constant</string>
                <key>scope</key>
                <string>support.constant.property-value.css</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#cad3f5</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>CSS suffix</string>
                <key>scope</key>
                <string>constant.numeric.suffix.css, keyword.other.unit.css</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string>italic</string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>CSS variable property</string>
                <key>scope</key>
                <string>variable.other.custom-property.name.css, support.type.custom-property.name.css, punctuation.definition.custom-property.css</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>SCSS tag</string>
                <key>scope</key>
                <string>entity.name.tag.css</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#b7bdf8</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>SASS variable</string>
                <key>scope</key>
                <string>variable.other.sass</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#8bd5ca</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Invalid</string>
                <key>scope</key>
                <string>invalid</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#cad3f5</string>
                  <key>background</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Invalid deprecated</string>
                <key>scope</key>
                <string>invalid.deprecated</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#cad3f5</string>
                  <key>background</key>
                  <string>#c6a0f6</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Diff header</string>
                <key>scope</key>
                <string>meta.diff, meta.diff.header</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#6e738d</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Diff deleted</string>
                <key>scope</key>
                <string>markup.deleted</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Diff inserted</string>
                <key>scope</key>
                <string>markup.inserted</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#a6da95</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Diff changed</string>
                <key>scope</key>
                <string>markup.changed</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#eed49f</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
              <dict>
                <key>name</key>
                <string>Message error</string>
                <key>scope</key>
                <string>message.error</string>
                <key>settings</key>
                <dict>
                  <key>foreground</key>
                  <string>#ed8796</string>
                  <key>fontStyle</key>
                  <string></string>
                </dict>
              </dict>
            </array>
            <key>uuid</key>
            <string>4d0379b5-ef82-467b-b8b8-365889420646</string>
            <key>colorSpaceName</key>
            <string>sRGB</string>
            <key>semanticClass</key>
            <string>theme.dark.Catppuccin</string>
            <key>author</key>
            <string>BrunDerSchwarzmagier</string>
          </dict>
        </plist>
       '';
    };
  };
}
