# decide

Decide is a tiny library to easily make state machines and decision flows in Lua. Written
in Lua 5.1.

# Installation

    luarocks install --server=http://luarocks.org/dev decide

# Documentation

## Including in a project

    D = require 'decide'

## How it works

You use the make function to set up a state machine. A state machine is really just a
collection of functions which are called according to a transition table. The functions
share a state (just a table), which they can modify as the state machine goes along,
and the entry function in the transition table can use the global state to decide whether
any given transition is presently valid.

It's very simple, so I encourage you to read the code directly (decide.lua) and the examples
in test.impl.lua.


##  make(trans, initial, state) -> {}

A state function looks like this:

    function yourfun(state)
    end

It can read and modify the state, which is just a table. It's return value is ignored.

Creates a new state machine. **trans** specifies the transition table which should be in
the following format.

    {{FR=<function>, TO=<function>, EN=<bool function>},
     ...
    }

The transitions are always considered in the order in which they were specified.

The TO function is optional, but if it's nil the flow will terminate there if it's selected.
The EN (entry) function is an optional boolean function but if it's nil it's as if it always
returns true.

**initial** specifies which function to start at, and **state** specifies the initial state.

Please see **test.impl.lua** for examples.

##  inc(self) -> {} or nil

Moves the state machine on one transition. Returns the current state if it's successful
or returns nil if the machine has halted.

##  stop(self) -> nil 

Halts the machine. I.e. sets the halt flag so that **inc** would return nil on next call.

# Test suite

There are basic smoke tests and examples in test.impl.lua. To run them:

    lua test.impl.lua

# License

MIT Licensed, please see LICENSE file for more information.
