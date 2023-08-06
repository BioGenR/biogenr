# Gerekli paketi indirme ve aktif hale getirme

install.packages("circlize")
library(circlize)

# Görüntü parametrelerini ayarlayın
circos.par(gap.degree = 0, cell.padding = c(0, 0, 0, 0), start.degree = 90)

# Bir çember grafiği başlatın ve x eksen sınırlarını belirtin
circos.initialize("a", xlim = c(0, 12))

# Arka plan kenarlığı olmayan bir izgi tanımı ekleyin
circos.track(ylim = c(0, 1), bg.border = NA)

# İç tarafta yer alan saat dilimleri için ekseni ekleyin
circos.axis(major.at = 0:12, labels = NULL, direction = "inside", 
            major.tick.length = mm_y(2))

# Saat sayılarını aşağıya doğru yerleştirin
circos.text(1:12, rep(1, 12) - mm_y(6), 1:12, facing = "downward")

# Şu anki zamanı alın
current.time = as.POSIXlt(Sys.time())
sec = ceiling(current.time$sec)
min = current.time$min
hour = current.time$hour

# Saniye okunun derecesini hesaplayın ve çizdirin
sec.degree = 90 - sec/60 * 360
arrows(0, 0, cos(sec.degree/180*pi)*0.8, sin(sec.degree/180*pi)*0.8)

# Dakika okunun derecesini hesaplayın ve kalın bir okla çizdirin
min.degree = 90 - min/60 * 360
arrows(0, 0, cos(min.degree/180*pi)*0.7, sin(min.degree/180*pi)*0.7, lwd = 2)   

# Saat okunun derecesini hesaplayın ve kalın bir okla çizdirin
hour.degree = 90 - hour/12 * 360 - min/60 * 360/12
arrows(0, 0, cos(hour.degree/180*pi)*0.4, sin(hour.degree/180*pi)*0.4, lwd = 2)
