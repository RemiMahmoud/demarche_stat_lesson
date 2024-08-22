# .Rprofile
if (interactive()) {
  # Charger les packages nécessaires
  if (!requireNamespace("tictoc", quietly = TRUE)) {
    install.packages("tictoc")
  }
  if (!requireNamespace("later", quietly = TRUE)) {
    install.packages("later")
  }
  library(tictoc)
  library(later)
  
  ###########################################
  ###########################################
  ## Chargement des packages et du jeu de données utilisé dans le cours
  library(dplyr)
  library(ggplot2)
  conflicted::conflict_prefer("filter", "dplyr")
  conflicted::conflict_prefer("select", "dplyr")
  
  ###########################################
  ###########################################
  ###########################################
  
  # Variables globales pour suivre l'activité
  .active <<- FALSE
  .last_active_time <<- Sys.time()
  
  # Vérifier et ajuster le fichier log au démarrage
  adjust_log_file <- function() {
    if (file.exists("time_log.txt")) {
      log_entries <- readLines("time_log.txt")
      start_count <- length(grep("Start", log_entries))
      stop_count <- length(grep("Stop", log_entries))
      if (start_count > stop_count) {
        # Ajouter un Stop manquant
        log_entry <- paste(Sys.time(), " - Stop (adjustment)", sep = "")
        write(log_entry, file = "time_log.txt", append = TRUE)
      }
    }
  }
  
  adjust_log_file()
  
  
  # Fonction pour démarrer le chronomètre et écrire dans le fichier log
  start_timer <- function() {
    if (!.active) {
      .active <<- TRUE  # Modifier la variable globale
      tic()
      log_entry <- paste(Sys.time(), " - Start", sep = "")
      write(log_entry, file = "time_log.txt", append = TRUE)
    }
  }
  
  # Fonction pour arrêter le chronomètre et écrire dans le fichier log
  stop_timer <- function() {
    if (.active) {
      .active <<- FALSE  # Modifier la variable globale
      toc()
      log_entry <- paste(Sys.time(), " - Stop", sep = "")
      write(log_entry, file = "time_log.txt", append = TRUE)
    }
  }
  
  # Fonction pour vérifier l'inactivité
  check_inactivity <- function() {
    if (Sys.time() - .last_active_time > 5 * 60) {  # 5 minutes d'inactivité
      stop_timer()
    }
    later(check_inactivity, 60)  # Vérifier toutes les 60 secondes
  }
  
  # Enregistrer l'activité de l'utilisateur
  register_activity <- function() {
    .last_active_time <<- Sys.time()  # Modifier la variable globale
    if (!.active) {
      start_timer()
    }
  }
  
  # Démarrer la vérification de l'inactivité
  later(check_inactivity, 60)
  
  # Démarrer le chronomètre automatiquement à l'ouverture de la session
  start_timer()
  
  # Définir une fonction de fin de session pour arrêter le chronomètre
  .Last <- function() {
    stop_timer()
  }
  
  # Hook pour détecter l'activité de l'utilisateur dans la console
  addTaskCallback(function(expr, value, ok, visible) {
    register_activity()
    TRUE
  })
}
