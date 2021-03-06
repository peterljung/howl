-- Copyright 2012-2017 The Howl Developers
-- License: MIT (see LICENSE.md at the top-level directory of the distribution)

{:app, :interact} = howl
{:Preview} = howl.interactions.util
{:highlight} = howl.ui

add_highlight = (type, buffer, line, opts) ->
  {:start_pos, :end_pos} = opts
  local l_start_pos, l_b_start_offset

  if opts.byte_start_pos
    start_pos = buffer\char_offset opts.byte_start_pos

  if opts.byte_end_pos
    end_pos = buffer\char_offset opts.byte_end_pos

  unless start_pos
    if opts.start_column
      l_start_pos or= line.start_pos
      start_pos = l_start_pos + opts.start_column - 1
    elseif opts.start_index
      l_b_start_offset or= line.byte_start_pos
      start_pos = buffer\char_offset l_b_start_offset + opts.start_index - 1

  unless end_pos
    if opts.count
      end_pos = start_pos + opts.count
    elseif opts.end_column
      l_start_pos or= line.start_pos
      end_pos = l_start_pos + opts.end_column - 1
    elseif opts.end_index
      l_b_start_offset or= line.byte_start_pos
      end_pos = buffer\char_offset l_b_start_offset + opts.end_index - 1

  unless start_pos and end_pos
    log.error "Invalid location highlight specified"
    return

  highlight.apply type, buffer, start_pos, end_pos - start_pos

interact.register
  name: 'select_location'
  description: 'Selection list for locations - a location consists of a file (or buffer) and line number'
  handler: (opts) ->
    opts = moon.copy opts
    editor = opts.editor or app.editor

    if howl.config.preview_files or opts.force_preview
      on_change = opts.on_change
      preview = Preview!

      opts.on_change = (sel, text, items) ->
        if sel
          buffer = sel.buffer or preview\get_buffer sel.file
          editor\preview buffer

          highlight.remove_all 'search', buffer
          highlight.remove_all 'search_secondary', buffer

          if sel.line_nr
            editor.line_at_center = sel.line_nr

            if sel.highlights and #sel.highlights > 0
              line = buffer.lines[sel.line_nr]
              add_highlight 'search', buffer, line, sel.highlights[1]

              for i = 2, #sel.highlights
                add_highlight 'search_secondary', buffer, line, sel.highlights[i]

        if on_change
          on_change sel, text, items

    result = interact.select opts
    editor\cancel_preview!

    return result
