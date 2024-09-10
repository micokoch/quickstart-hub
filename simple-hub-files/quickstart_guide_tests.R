### Quickstart Guide Tests

library(hubAdmin)

validate_config(
  hub_path = ".",
  config = c("tasks", "admin"), 
  config_path = NULL, 
  schema_version = "from_config", 
  branch = "main"
)

