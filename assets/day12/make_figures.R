args <- commandArgs(trailingOnly = FALSE)
script_path <- sub("^--file=", "", args[grepl("^--file=", args)])
output_dir <- dirname(normalizePath(script_path))

ink <- "#252525"
green <- "#237451"
blue <- "#246c9c"
purple <- "#775791"
grid_color <- "#dedede"

open_figure <- function(filename, width = 1500, height = 850) {
  png(file.path(output_dir, filename), width = width, height = height, res = 190)
  par(family = "sans", col = ink, col.axis = ink, col.lab = ink,
      col.main = ink, cex = 1, las = 1, bty = "n")
}

# Each value is illustrative; no external records are used.
open_figure("category_comparison.png", width = 1800, height = 850)
par(mfrow = c(1, 2), mar = c(4.5, 7.5, 3, 2))
visits <- c(History = 40, Biology = 60, Mathematics = 90)
barplot(visits, horiz = TRUE, col = green, border = NA, xlim = c(0, 100),
        xlab = "Completed visits", main = "Bar chart", axes = FALSE)
axis(1, at = seq(0, 100, 20))
text(visits + 3, c(0.7, 1.9, 3.1), labels = visits, adj = 0)
plot(visits, seq_along(visits), pch = 19, col = blue, cex = 1.6,
     xlim = c(0, 100), ylim = c(0.6, 3.4), yaxt = "n", xaxt = "n",
     xlab = "Completed visits", ylab = "", main = "Dot plot")
axis(1, at = seq(0, 100, 20))
axis(2, at = seq_along(visits), labels = names(visits), tick = FALSE)
segments(0, seq_along(visits), visits, seq_along(visits), col = grid_color)
points(visits, seq_along(visits), pch = 19, col = blue, cex = 1.6)
text(visits + 3, seq_along(visits), labels = visits, adj = 0)
dev.off()

open_figure("counts_percentages.png", height = 750)
par(mfrow = c(1, 2), mar = c(4, 4.5, 3, 1))
participants <- c(East = 80, West = 100)
eligible <- c(East = 200, West = 500)
positions <- barplot(participants, col = c(green, blue), border = NA,
                     ylim = c(0, 120), ylab = "Students with a completed visit",
                     main = "Tutoring users")
text(positions, participants + 6, labels = participants)
percentages <- 100 * participants / eligible
positions <- barplot(percentages, col = c(green, blue), border = NA,
                     ylim = c(0, 50), ylab = "Percent of eligible students",
                     main = "Participation percentage")
text(positions, percentages + 3, labels = paste0(percentages, "%"))
dev.off()

open_figure("monthly_trend.png")
par(mar = c(4, 4.5, 3, 1))
months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun")
monthly <- c(120, 160, 140, 200, 180, 220)
plot(seq_along(months), monthly, type = "n", xaxt = "n", yaxt = "n",
     xlim = c(0.8, 6.2), ylim = c(0, 250), xlab = "Month",
     ylab = "Completed visits", main = "Recorded completed visits by month")
abline(h = seq(0, 250, 50), col = grid_color)
axis(1, at = seq_along(months), labels = months)
axis(2, at = seq(0, 250, 50))
lines(seq_along(months), monthly, col = green, lwd = 2)
points(seq_along(months), monthly, col = green, pch = 19, cex = 1.3)
text(seq_along(months), monthly + 13, labels = monthly)
dev.off()

open_figure("score_distribution.png")
par(mar = c(4, 4.5, 3, 1))
scores <- c(55, 60, 62, 65, 66, 68, 69, 70, 71, 72, 73, 74, 75, 75,
            76, 77, 78, 78, 79, 80, 80, 81, 82, 82, 83, 84, 85, 85,
            86, 87, 88, 89, 90, 91, 92, 93, 94, 96, 97, 98)
hist(scores, breaks = seq(50, 100, 10), right = FALSE, col = blue,
     border = "white", xlab = "Final grade (0-100 points)", ylab = "Students",
     main = "Distribution of recorded final grades", ylim = c(0, 16),
     xaxt = "n")
axis(1, at = seq(50, 100, 10))
dev.off()

open_figure("group_boxplots.png")
par(mar = c(4, 4.5, 3, 1))
grades <- list(
  "No completed visit recorded" = c(45, 58, 62, 65, 68, 70, 72, 74, 76, 78,
                                     80, 82, 84, 86, 89, 92),
  "At least one completed visit" = c(58, 65, 70, 73, 76, 79, 81, 83, 84, 85,
                                     86, 88, 90, 92, 94, 98)
)
boxplot(grades, col = c(green, blue), border = ink, ylim = c(0, 100),
        ylab = "Final grade (0-100 points)", main = "Grade distributions by tutoring use",
        names = c("No completed visit\nrecorded (n = 16)",
                  "At least one completed\nvisit (n = 16)"))
dev.off()

open_figure("visits_grades_scatter.png")
par(mar = c(4, 4.5, 3, 1))
student_visits <- rep(0:6, each = 5)
student_grades <- 60 + 3 * student_visits + rep(c(-10, -5, 0, 5, 10), 7)
plot(student_visits, student_grades, pch = 19, col = blue, cex = 1.2,
     xlim = c(-0.3, 6.3), ylim = c(40, 100), xaxt = "n",
     xlab = "Completed tutoring visits per student",
     ylab = "Recorded final grade (0-100 points)",
     main = "Two numeric measures for the same students")
axis(1, at = 0:6)
dev.off()

open_figure("appointment_composition.png", height = 950)
par(mar = c(7, 5, 3, 2))
shares <- rbind(Completed = c(60, 80), Canceled = c(25, 15),
                "No-show" = c(15, 5))
colnames(shares) <- c("Fall", "Spring")
positions <- barplot(shares, horiz = TRUE, col = c(green, blue, purple),
                     border = "white", xlim = c(0, 100), axes = FALSE,
                     xlab = "Percent of recorded appointments",
                     main = "Composition of appointment outcomes")
axis(1, at = seq(0, 100, 20), labels = paste0(seq(0, 100, 20), "%"))
for (column in seq_len(ncol(shares))) {
  centers <- cumsum(shares[, column]) - shares[, column] / 2
  text(centers, rep(positions[column], 3), labels = paste0(shares[, column], "%"),
       col = "white", cex = 0.85)
}
legend(x = 50, y = -0.5, xjust = 0.5, yjust = 1, legend = rownames(shares),
       fill = c(green, blue, purple), border = NA, horiz = TRUE,
       bty = "n", xpd = NA, cex = 0.9)
dev.off()

message("Wrote seven illustrative chart figures to ", output_dir)
