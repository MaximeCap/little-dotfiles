return {
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
      hints = {
        compositeLiteralFields = true,
        assignVariableTypes = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      }
    },
  }
}
