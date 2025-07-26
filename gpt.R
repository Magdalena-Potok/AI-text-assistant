library(httr)
library(jsonlite)
library(openai)
openai_response <- function(prompt, input_api_key) {
  api_key <- input_api_key
  response <- POST(
    url = "https://api.openai.com/v1/chat/completions",
    add_headers(
      Authorization = paste("Bearer", api_key),
      "Content-Type" = "application/json"
    ),
    body = toJSON(list(
      model = "gpt-3.5-turbo",
      messages = list(
        list(role = "user", content = prompt)
      ),
      temperature = 0
    ), auto_unbox = TRUE)
  )
  
  content <- content(response, as = "parsed")
  return(content$choices[[1]]$message$content)
}


