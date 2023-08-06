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

#circos.par(): Bu fonksiyon, çember grafiği parametrelerini ayarlamak için kullanılır. gap.degree ile izgiler arasındaki boşluğu, cell.padding ile hücre kenar boşluklarını ve start.degree ile grafiğin başlangıç açısını belirleyebilirsiniz.

#circos.initialize(): Çember grafiğini başlatır ve içinde izgileri oluşturmak için bir temel oluşturur. "a" argümanıyla bir izgi adı belirtilirken, xlim ile x ekseninin sınırları tanımlanır.

#circos.track(): Çember grafiğine bir izgi ekler. ylim ile izginin y ekseninin sınırlarını, bg.border ile arka plan kenarlığını ayarlayabilirsiniz.

#circos.axis(): Çember grafiğine ekseni ekler. major.at ile büyük çizgi konumlarını, labels ile etiketleri, direction ile çizgi yönünü ve major.tick.length ile büyük çizgi uzunluğunu belirleyebilirsiniz.

#circos.text(): Çember grafiğine metin etiketleri ekler. İkinci ve üçüncü argümanlarla konumlarını belirlerken, facing ile metin yönünü ayarlayabilirsiniz.

#as.POSIXlt(Sys.time()): Şu anki sistemin zamanını alarak bir POSIXlt zaman nesnesine dönüştürür. Bu, zamanla ilgili işlemleri gerçekleştirmenizi sağlar.

#ceiling(): Bir sayıyı yukarıya yuvarlar. Burada saniyeleri yukarı yuvarlayarak tam saniye değerini elde ediyoruz.

#cos() ve sin(): Trigonometrik fonksiyonlar olan kosinüs ve sinüs hesaplamalarını yapar. Burada, saniye, dakika ve saat değerlerini kullanarak okların x ve y koordinatlarını hesaplamak için kullanılır.

#arrows(): İki nokta arasına bir ok çizer. İlk iki argümanlar okun başlangıç noktasını temsil ederken, son iki argümanlar okun bitiş noktasını temsil eder. lwd argümanıyla okun kalınlığını ayarlayabilirsiniz.
