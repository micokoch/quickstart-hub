library(hubAdmin)

origin_date_id <- create_task_id(
  "origin_date",
  required = NULL,
  optional = c("2023-01-02", "2023-01-09", "2023-01-16")
)

location_id <- create_task_id("location",
                              required = "US",
                              optional = c("01", "02", "04", "05", "06"))

horizon_id <- create_task_id("horizon", required = 1L, optional = 2:4)

task_ids_example <- create_task_ids(origin_date_id, location_id, horizon_id)

mean_example <- create_output_type_mean(
  is_required = TRUE,
  value_type = "double",
  value_minimum = 0L
)

median_example <- create_output_type_median(
  is_required = FALSE,
  value_type = "integer"
)

output_type_example <-  create_output_type(mean_example, median_example)

target_metadata_item1 <- 
  create_target_metadata_item(
    target_id = "inc hosp",
    target_name = "Weekly incident influenza hospitalizations",
    target_units = "rate per 100,000 population",
    target_keys = NULL,
    target_type = "discrete",
    is_step_ahead = TRUE,
    time_unit = "week"
  )

target_metadata_item2 <- create_target_metadata_item(
  target_id = "inc death",
  target_name = "Weekly incident influenza deaths",
  target_units = "rate per 100,000 population",
  target_keys = list(target = "inc death"),
  target_type = "discrete",
  is_step_ahead = TRUE,
  time_unit = "week"
)

target_metadata_example <- create_target_metadata(target_metadata_item1, target_metadata_item2)

model_task_example <- create_model_task(
  task_ids = task_ids_example, 
  output_type = output_type_example, 
  target_metadata = target_metadata_example
)

round1 <- create_round(
  round_id_from_variable = TRUE,
  round_id = "origin_date", 
  round_name = "Round 1", 
  model_tasks = model_task_example, 
  submissions_due = list(
    relative_to = "origin_date",
    start = -4L,
    end = 2L
  )
)

round2 <- create_round(
  round_id_from_variable = TRUE,
  round_id = "origin_date", 
  round_name = "Round 2", 
  model_tasks = model_task_example, 
  submissions_due = list(
    start = "2023-01-09", 
    end = "2023-01-16"
  )
)

rounds <- create_rounds(round1, round2)
create_config(rounds)



rounds <- create_rounds(
  create_round(
    round_id_from_variable = TRUE,
    round_id = "origin_date",
    model_tasks = create_model_tasks(
      create_model_task(
        task_ids = create_task_ids(
          create_task_id("origin_date",
                         required = NULL,
                         optional = c(
                           "2023-01-02",
                           "2023-01-09",
                           "2023-01-16"
                         )
          ),
          create_task_id("location",
                         required = "US",
                         optional = c("01", "02", "04", "05", "06")
          ),
          create_task_id("horizon",
                         required = 1L,
                         optional = 2:4
          )
        ),
        output_type = create_output_type(
          create_output_type_mean(
            is_required = TRUE,
            value_type = "double",
            value_minimum = 0L
          )
        ),
        target_metadata = create_target_metadata(
          create_target_metadata_item(
            target_id = "inc hosp",
            target_name = "Weekly incident influenza hospitalizations",
            target_units = "rate per 100,000 population",
            target_keys = NULL,
            target_type = "discrete",
            is_step_ahead = TRUE,
            time_unit = "week"
          )
        )
      )
    ),
    submissions_due = list(
      relative_to = "origin_date",
      start = -4L,
      end = 2L
    )
  )
)
# config <- create_config(rounds)
# write(config, "config.json")
