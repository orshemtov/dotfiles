return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    set({ "n", "x" }, "<leader>m", function() end, { desc = "Multicursor" })

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<M-u>", function()
      mc.lineAddCursor(-1)
    end, { desc = "Add cursor above" })
    set({ "n", "x" }, "<M-d>", function()
      mc.lineAddCursor(1)
    end, { desc = "Add cursor below" })
    set({ "n", "x" }, "<leader><up>", function()
      mc.lineSkipCursor(-1)
    end, { desc = "Skip cursor above" })
    set({ "n", "x" }, "<leader><down>", function()
      mc.lineSkipCursor(1)
    end, { desc = "Skip cursor below" })

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "x" }, "<leader>mn", function()
      mc.matchAddCursor(1)
    end, { desc = "Add cursor at next match" })
    set({ "n", "x" }, "<leader>ms", function()
      mc.matchSkipCursor(1)
    end, { desc = "Skip cursor at next match" })
    set({ "n", "x" }, "<leader>mN", function()
      mc.matchAddCursor(-1)
    end, { desc = "Add cursor at previous match" })
    set({ "n", "x" }, "<leader>mS", function()
      mc.matchSkipCursor(-1)
    end, { desc = "Skip cursor at previous match" })

    -- Add and remove cursors with control + left click.
    set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Add/remove cursor with mouse" })
    set("n", "<c-leftdrag>", mc.handleMouseDrag, { desc = "Drag cursor with mouse" })
    set("n", "<c-leftrelease>", mc.handleMouseRelease, { desc = "Release cursor mouse" })

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)

      -- Delete the main cursor.
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    vim.keymap.set({ "n", "x" }, "<C-q>", function()
      mc.toggleCursor()
      vim.schedule(function()
        vim.notify(mc.cursorsEnabled() and "MultiCursor: enabled" or "MultiCursor: disabled")
      end)
    end, { desc = "Toggle cursor with notification" })

    -- Pressing `gaip` will add a cursor on each line of a paragraph.
    set("n", "ga", mc.addCursorOperator, { desc = "Add cursor operator" })

    -- Clone every cursor and disable the originals.
    set({ "n", "x" }, "<leader>md", mc.duplicateCursors, { desc = "Duplicate cursors" })

    -- Align cursor columns.
    set("n", "<leader>ml", mc.alignCursors, { desc = "Align cursors" })

    -- Split visual selections by regex.
    set("x", "<leader>mR", mc.splitCursors, { desc = "Split cursors by regex" })

    -- match new cursors within visual selections by regex.
    set("x", "<leader>mM", mc.matchCursors, { desc = "Match cursors by regex" })

    -- bring back cursors if you accidentally clear them
    set("n", "<leader>mV>", mc.restoreCursors, { desc = "Restore Cursors" })

    -- Add a cursor for all matches of cursor word/selection in the document.
    set({ "n", "x" }, "<leader>mA", mc.matchAllAddCursors, { desc = "Match all cursors" })

    -- Rotate the text contained in each visual selection between cursors.
    set("x", "<leader>mt", function()
      mc.transposeCursors(1)
    end, { desc = "Transpose cursors forward" })
    set("x", "<leader>mT", function()
      mc.transposeCursors(-1)
    end, { desc = "Transpose cursors backward" })

    -- Append/insert for each line of visual selections.
    -- Similar to block selection insertion.
    set("x", "I", mc.insertVisual, { desc = "Insert at cursors" })
    set("x", "A", mc.appendVisual, { desc = "Append at cursors" })

    -- Increment/decrement sequences, treaing all cursors as one sequence.
    set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement, { desc = "Increment sequence at cursors" })
    set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement, { desc = "Decrement sequence at cursors" })

    -- Add a cursor or jump to the next/previous search result.
    set("n", "<leader>m/n", function()
      mc.searchAddCursor(1)
    end, { desc = "Search add cursor forward" })
    set("n", "<leader>m/N", function()
      mc.searchAddCursor(-1)
    end, { desc = "Search add cursor backward" })

    -- Jump to the next/previous search result without adding a cursor.
    set("n", "<leader>m/s", function()
      mc.searchSkipCursor(1)
    end, { desc = "Search skip cursor forward" })
    set("n", "<leader>m/S", function()
      mc.searchSkipCursor(-1)
    end, { desc = "Search skip cursor backward" })

    -- Add a cursor to every search result in the buffer.
    set("n", "<leader>m/A", mc.searchAllAddCursors, { desc = "Search add all cursors" })

    -- Pressing `<leader>miwap` will create a cursor in every match of the
    -- string captured by `iw` inside range `ap`.
    -- This action is highly customizable, see `:h multicursor-operator`.
    set({ "n", "x" }, "<leader>mo", mc.operator, { desc = "Multicursor operator" })

    -- Add or skip adding a new cursor by matching diagnostics.
    set({ "n", "x" }, "<leader>m]d", function()
      mc.diagnosticAddCursor(1)
    end, { desc = "Diagnostic add cursor forward" })
    set({ "n", "x" }, "<leader>m[d", function()
      mc.diagnosticAddCursor(-1)
    end, { desc = "Diagnostic add cursor backward" })
    set({ "n", "x" }, "<leader>m]s", function()
      mc.diagnosticSkipCursor(1)
    end, { desc = "Diagnostic skip cursor forward" })
    set({ "n", "x" }, "<leader>m[S", function()
      mc.diagnosticSkipCursor(-1)
    end, { desc = "Diagnostic skip cursor backward" })

    -- Press `mdip` to add a cursor for every error diagnostic in the range `ip`.
    set({ "n", "x" }, "md", function()
      -- See `:h vim.diagnostic.GetOpts`.
      mc.diagnosticMatchCursors({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Match cursors at error diagnostics" })

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
