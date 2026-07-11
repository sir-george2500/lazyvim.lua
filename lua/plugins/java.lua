-- Java + Spring Boot on top of the LazyVim lang.java extra (jdtls, debug, test).
-- spring-boot.nvim runs the Spring Boot language server (mason: spring-boot-tools)
-- for application properties/yaml and live Spring symbols in Java code.
--
-- Note: spring-boot.nvim looks the package up under mason's OLD name
-- ("vscode-spring-boot-tools"), so we point it at the current
-- "spring-boot-tools" package paths explicitly.
local boot_extension = vim.fn.stdpath("data") .. "/mason/packages/spring-boot-tools/extension"

return {
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "yaml", "jproperties" },
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      ls_path = boot_extension .. "/language-server",
      exploded_ls_jar_data = true,
    },
  },

  -- keep the Spring Boot language server installed
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "spring-boot-tools" } },
  },

  -- append spring-boot's jdtls extensions to the bundles the java extra builds
  -- (opts.jdtls as a function lets us extend the final config without
  -- clobbering the java-debug/java-test bundles)
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- make sure mason has loaded (sets $MASON and puts its bin dir on PATH)
      -- before the java extra resolves the jdtls command and bundle globs
      pcall(require, "mason")
      if opts.cmd and (opts.cmd[1] == nil or opts.cmd[1] == "") then
        for _, bin in ipairs({
          vim.fn.stdpath("data") .. "/mason/bin/jdtls",
          vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls",
        }) do
          if vim.uv.fs_stat(bin) then
            opts.cmd[1] = bin
            break
          end
        end
      end
      opts.jdtls = function(config)
        config.init_options = config.init_options or {}
        config.init_options.bundles = config.init_options.bundles or {}
        vim.list_extend(config.init_options.bundles, require("spring_boot").java_extensions(boot_extension .. "/jars"))
        return config
      end
    end,
  },
}
