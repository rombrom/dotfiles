// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// Phoenix Window Manager Configuration
// Author: Rommert Zijlstra
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// Constants
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

const keys = {
  mod:  ['cmd', 'ctrl'],
  mash: ['alt', 'cmd', 'ctrl'],
  mush: ['cmd', 'ctrl', 'shift'],
}

const padding = 4
const modeTime = 2 // 2 seconds

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// Primitives
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

function Point (x, y, includePadding = true) {
  return {
    x: Math.round(x + (includePadding && padding)),
    y: Math.round(y + (includePadding && padding)),
  }
}

function Rect (x, y, width, height, includePadding = true) {
  return {
    x:      Math.round(x + (includePadding && padding)),
    y:      Math.round(y + (includePadding && padding)),
    width:  Math.round(width - ((includePadding && padding) * 2)),
    height: Math.round(height - ((includePadding && padding) * 2)),
  }
}

function Size (width, height, includePadding = true) {
  return {
    width:  Math.round(width - ((includePadding && padding) * 2)),
    height: Math.round(height - ((includePadding && padding) * 2)),
  }
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// Helpers
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

function getFocusedWindow () {
  return Window.focused()
}

function getActiveScreenRect (win, visibleFrame = true) {
  return visibleFrame
    ? win.screen().flippedVisibleFrame()
    : win.screen().flippedFrame()
}

function isWidescreen ({width, height}) {
  return width / height > 2
}

function centerModal (modal, screenRect) {
  let modalFrame = modal.frame()

  modal.origin = Point(
    (screenRect.width - modalFrame.width) / 2,
    (screenRect.height - modalFrame.height) / 2,
    false
  )
}

function uniqueMax (x) {
  return (value, index, self) => self.indexOf(value) === index && value <= x
}

function moveToColumns (focusedWindow, screenRect, positions, columns) {
  let startPosition   = positions[0] - 1,
      columMultiplier = positions.length
      columnWidth     = Math.ceil(screenRect.width / columns)

  focusedWindow.setFrame(
    Rect(
      screenRect.x + startPosition * columnWidth,
      screenRect.y,
      columnWidth * columMultiplier,
      screenRect.height
    )
  )
}

function moveToQuadrants (focusedWindow, screenRect, positions, columns) {
  let topPositions    = positions.filter(value => value <= columns),
      bottomPositions = positions.filter(value => value > columns).map(value => value - columns),
      startPosition   = Math.min.apply(Math, [...topPositions, ...bottomPositions]) - 1,
      columMultiplier = Math.max.apply(Math, [topPositions.length, bottomPositions.length])
      columnWidth     = Math.ceil(screenRect.width / columns)

  focusedWindow.setFrame(
    Rect(
      screenRect.x + (startPosition * columnWidth),
      topPositions.length ? screenRect.y : screenRect.y + (screenRect.height / 2),
      columnWidth * columMultiplier,
      topPositions.length && bottomPositions.length ? screenRect.height : screenRect.height / 2
    )
  )
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// Key bindings
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

// Throw left
Key.on('[', keys.mod, () => {
  let focusedWindow = getFocusedWindow(),
      screenRect    = getActiveScreenRect(focusedWindow)

  focusedWindow.setFrame(
    Rect(
      screenRect.x,
      screenRect.y,
      screenRect.width * 0.5,
      screenRect.height
    )
  )
})

// Throw right
Key.on(']', keys.mod, () => {
  let focusedWindow = getFocusedWindow(),
      screenRect    = getActiveScreenRect(focusedWindow)

  focusedWindow.setFrame(
    Rect(
      screenRect.x + screenRect.width * 0.5,
      screenRect.y,
      screenRect.width * 0.5,
      screenRect.height
    )
  )
})

// Center screen
Key.on('c', keys.mod, () => {
  let focusedWindow = getFocusedWindow(),
      screenRect    = getActiveScreenRect(focusedWindow),
      resizedRect   = isWidescreen(screenRect)
        ? Rect(
            screenRect.x + screenRect.width  * 0.25,
            screenRect.y + screenRect.height * 0.1,
            screenRect.width  * 0.5,
            screenRect.height * 0.8
          )
        : Rect(
            screenRect.x + screenRect.width  * 0.1,
            screenRect.y + screenRect.height * 0.1,
            screenRect.width  * 0.8,
            screenRect.height * 0.8
          )

  focusedWindow.setFrame(resizedRect)
})

// Maximize screen
Key.on('c', keys.mash, () => {
  let focusedWindow = getFocusedWindow(),
      screenRect    = getActiveScreenRect(focusedWindow)

  focusedWindow.maximize()
})

// Columns
const columns = [1, 2, 3]
columns.forEach(index => {
  Key.on(index, keys.mod, () => {
    let focusedWindow = getFocusedWindow(),
        screenRect    = getActiveScreenRect(focusedWindow)

    focusedWindow.setFrame(
      Rect(
        screenRect.x + screenRect.width * ((index -1) / 3),
        screenRect.y,
        screenRect.width * (1 / 3),
        screenRect.height
      )
    )
  })
})

// Resizing, nudging, throwing
const directions = {
  down:  { x:  0,   y:  0.1},
  left:  { x: -0.1, y:  0},
  right: { x:  0.1, y:  0},
  up:    { x: -0,   y: -0.1},
}

Object.keys(directions).forEach(key => {

  // Resize
  Key.on(key, keys.mash, () => {
    let focusedWindow = getFocusedWindow(),
        screenRect    = getActiveScreenRect(focusedWindow),
        focusedFrame  = focusedWindow.frame()

    focusedWindow.setSize(
      Size(
        focusedFrame.width + (screenRect.width * directions[key].x),
        focusedFrame.height + (screenRect.height * directions[key].y),
        false
      )
    )
  })

  // Nudge
  Key.on(key, keys.mod, () => {
    let focusedWindow = getFocusedWindow(),
        screenRect    = getActiveScreenRect(focusedWindow),
        focusedFrame  = focusedWindow.frame()

    focusedWindow.setTopLeft(
      Point(
        focusedFrame.x + (screenRect.width * directions[key].x),
        focusedFrame.y + (screenRect.height * directions[key].y),
        false
      )
    )
  })

  // Throw
  Key.on(key, keys.mush, () => {
    let focusedWindow = getFocusedWindow(),
        screenRect    = getActiveScreenRect(focusedWindow, false),
        focusedFrame  = focusedWindow.frame(),
        updatedX      = focusedFrame.x,
        updatedY      = focusedFrame.y

    switch (key) {
      case 'down':
        updatedY = screenRect.y + (screenRect.height - focusedFrame.height)
        break
      case 'left':
        updatedX = screenRect.x
        break
      case 'right':
        updatedX = screenRect.x + (screenRect.width - focusedFrame.width)
        break
      case 'up':
        updatedY = screenRect.y
        break
    }

    focusedWindow.setTopLeft(
      Point(updatedX, updatedY, false)
    )
  })

})

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// Experiments
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

/* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ \

VIM like window manager

  CTRL + CMD + SHIFT + X (or something) = Enter mode

  M = Move
  R = Resize

  1 = Col 1 | Half 1 | Quadrant 1
  2 = Col 2 | Half 2 | Quadrant 2
  3 = Col 3 | Quadrant 3
  4 = Quadrant 4

  C = Columns
  H = Half
  Q = Quadrant

  ↑ = Up
  → = Right
  ↓ = Down
  ← = Left

  / = Half horizontally
  \ = Half vertically

  ESC = Exit mode

\ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */

let KeyBinder = {
  keyHandlers   : {},

  on (key, callback) {
    if (this.keyHandlers[key]) this.off(key)

    return this.keyHandlers[key] = Key.on(key, null, callback)
  },

  off (key) {
    Key.off(this.keyHandlers[key])
    delete this.keyHandlers[key]
  },

  once (key, callback) {
    this.on(key, (keyHandler, keyRepeat) => {
      callback(keyHandler, keyRepeat)
      this.off(key)
    })
  },

  clean () {
    Object.keys(this.keyHandlers)
      .forEach(key => this.off(key))
  }
}

let modalWindowManager = Key.on('x', ['cmd', 'ctrl'], enterHandler => {

  let focusedWindow     = getFocusedWindow(),
      screenRect        = getActiveScreenRect(focusedWindow),
      allowedPositions  = isWidescreen(screenRect) ? [1, 2, 3, 4, 5, 6] : [1, 2, 3, 4],
      enteredPositions  = [],
      columns           = 3,
      rows              = 2

  Phoenix.log('Entering modalWindowManagement mode...')
  enterHandler.disable()

  KeyBinder.once('m', moveHandler => {
    Phoenix.log('Move mode enabled...')
    KeyBinder.off('r')

    allowedPositions.forEach(key => KeyBinder.on(key, () => {
      enteredPositions.push(key)
    }))

    KeyBinder.once('c', () => {
      enteredPositions = enteredPositions.sort().filter(uniqueMax(columns))
      enteredPositions.length && moveToColumns(focusedWindow, screenRect, enteredPositions, columns)
      exitModalWindowManager()
    })

    KeyBinder.once('h', () => {
      columns = 2
      enteredPositions = enteredPositions.sort().filter(uniqueMax(columns))
      enteredPositions.length && moveToColumns(focusedWindow, screenRect, enteredPositions, columns)
      exitModalWindowManager()
    })

    KeyBinder.once('q', () => {
      enteredPositions = enteredPositions.sort().filter(uniqueMax(6))
      enteredPositions.length && moveToQuadrants(focusedWindow, screenRect, enteredPositions, columns)
      exitModalWindowManager()
    })

  })

  KeyBinder.once('r', moveHandler => {
    Phoenix.log('Resize mode enabled...')
    KeyBinder.off('m')

  })

  KeyBinder.once('x', exitModalWindowManager)

  function exitModalWindowManager() {
    Phoenix.log('Exiting modalWindowManagement mode...')
    enterHandler.enable()
    KeyBinder.clean()
  }

})

// Make a modal window manager. CTRL + CMD + Z makes Phoenix go into modal state
// expecting a column to throw the window to.
Key.on('z', keys.mod, (keyHandler) => {

  const modalProps  = {
    duration: modeTime,
    text    : 'Select column: ',
  }

  Key.on(null, null, Phoenix.log)

  let focusedWindow = getFocusedWindow(),
      screenRect    = getActiveScreenRect(focusedWindow),
      modal         = Modal.build(modalProps),
      columnBinds   = []

  keyHandler.disable()

  centerModal(modal, screenRect)

  modal.show()

  columns.forEach(index => {
    columnBinds.push(
      Key.on(index, null, () => {
        let focusedWindow = getFocusedWindow(),
            screenRect    = getActiveScreenRect(focusedWindow)

        modal.text = modal.text + index

        centerModal(modal, screenRect)

        focusedWindow.setFrame(
          Rect(
            screenRect.x + screenRect.width * ((index -1) / 3),
            screenRect.y,
            screenRect.width * (1 / 3),
            screenRect.height
          )
        )
      })
    )
  })

  let timerInstance = Timer.after(modeTime, () => {
    columnBinds.forEach(bind => {
      Key.off(bind)
    })

    keyHandler.enable()
  })
})