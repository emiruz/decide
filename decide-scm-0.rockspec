package = "decide"
version = "scm-0"

source = {
  url = "git://github.com/emiruz/decide.git",
}

description = {
  summary = "Easily make state machines and decision flows in Lua.",
  homepage = "https://github.com/emiruz/decide",
  license = "MIT/X11",
  maintainer = "emir@usgroupltd.uk",
  detailed = "Easily make state machines and decision flows in Lua."
}

dependencies = {
  "lua >= 5.1"
}

build = {
  type = "builtin",
  modules = { decide = "decide.lua" }
}
