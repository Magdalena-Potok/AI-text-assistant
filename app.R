library(shiny)
source("gpt.R")

ui <- fluidPage(
  titlePanel("AI Tekstowy Asystent"),
  textAreaInput("user_input", "Wpisz tekst:", rows = 5),
  textAreaInput("api_key_input", "Podaj klucz API:", rows = 1),
  selectInput("action", "Co chcesz zrobić?",
              choices = c("Klasyfikacja tekstu", "Streszczenie tekstu", "Parafraza tekstu")),
  actionButton("go", "Wyślij do GPT"),
  hr(),
  h4("Odpowiedź GPT:"),
  verbatimTextOutput("response")
)

server <- function(input, output) {
  observeEvent(input$go, {
    req(input$user_input, input$api_key_input)

    prompt <- switch(input$action,
                     "Klasyfikacja tekstu" = paste("Sklasyfikuj ten tekst jako pozytywny/negatywny albo neutralny:\n\n", input$user_input),
                     "Streszczenie tekstu" = paste("Streść ten tekst:\n\n", input$user_input),
                     "Parafraza tekstu" = paste("Sparafracuj ten tekst żeby był bardziej formalny:\n\n", input$user_input)
    )
    
    # Wywołaj GPT
    output$response <- renderText({
      openai_response(prompt, input$api_key_input)
    })
  })
}

shinyApp(ui, server)
