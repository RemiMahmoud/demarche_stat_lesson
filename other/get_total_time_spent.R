# Lecture et analyse du fichier log
log_entries <- readLines("time_log.txt")

# Afficher les entrées du fichier log
print(log_entries)

# Filtrer les entrées de début et de fin
start_times <- as.POSIXct(sub(" - Start", "", log_entries[grep("Start", log_entries)]))
stop_times <- as.POSIXct(sub(" - Stop", "", log_entries[grep("Stop", log_entries)]))

# Calcul du temps total passé
if (length(start_times) == length(stop_times)) {
  
  # Ajout de 10h pour comptabilisation temps passé en amont
  total_time <- sum(difftime(stop_times, start_times, units = "hours")) + 10
  print(paste("Total time spent on project: ", total_time, " seconds"))
} else if (length(start_times) == (length(stop_times) + 1)){
  # remove if the last start time value is the project currently running
  # Ajout de 10h pour comptabilisation temps passé en amont
  total_time <- sum(difftime(stop_times, start_times[-length(start_times)], units = "hours")) + 10
  print(paste("Total time spent on project: ", total_time, " seconds"))
  
} else {
  
  print("Mismatch between start and stop entries in the log file.")
}

