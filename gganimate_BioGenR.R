#Eğer bu paketlere sahip değilsen aşağıdaki kodlar yardımı ile eksik olan paketleri indirebilirsin.
#install.packages("gganimate")
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("gapminder")
#install.packages("ggthemes")
#install.packages("gifski")
#install.packages("av")
#install.packages("lubridate")


library(gganimate)
library(ggplot2)
library(dplyr)
library(gapminder)
library(ggthemes)
library(gifski)
library(av)
library(lubridate)

f_data <- read.csv("sequences.csv") #Ham haldeki veriyi içeren dosya read.csv() fonksiyonu ile okutulur. 

f_data_d <- f_data[order(as.Date(f_data$Release_Date, format="%Y-%m-%d")),] #Ham veri içerisindeki tarih verisi yıl/ay/gün şeklinde tekrar sıralanır.
na.omit(f_data_d) #Eliminate NA values from data frame to prevent errors

f_data_d <- f_data_d[-which(f_data_d$Country == ""), ] #"Countries" adlı kolon içerisindeki boş değerler atılır.

f_data_r <- f_data_d %>% filter(grepl("2021", Release_Date)) #"Release_Date" adlı kolon içerisindeki 2021 harici bütün değerler atılır. 

months <- month(as.POSIXlt(f_data_r$Release_Date, format="%Y-%m-%d")) #"Release_Date" kolonu içerisindeki ay değerleri tarih değişkeni cinsinde alınır. 

months <- as.data.frame(months) #Daha sonra elde edilen veri veri çerçevesi formatına dönüştürülür. 

f_data_merged <- cbind(months, f_data_r) #Yeni veri çerçevesi ile eski veri çerçevesi cbind() fonksiyonu ile kolon bazında birleştirilir. 

#İstenilen ülkeler özel olarak seçilir, akabinde tekrar sayılarına göre tekrar gruplanırlar.  
f_spc_data <- f_data_merged %>% dplyr::mutate(MonthName = month.name[months]) %>% filter(Country == "USA" |
                                        Country == "United Kingdom" |
                                        Country == "Switzerland" |
                                        Country == "Germany") %>%
  group_by(Country, months) %>% 
  summarise(reps = n())

f_spc_data <- f_spc_data %>% dplyr::mutate(MonthName = month.name[months]) #Yeni veri çerçevesine ay isimleri ile alakalı bir kolon eklenir

f_spc_data$MonthName <- factor(f_spc_data$MonthName, levels = c("January","February","March","April","May","June","July","August","September","October","November","December")) #Kolon içerisindeki aylar faktör cinsinden tanımlanır

#Veri görselleştirme bölümü başlangıcı
#Yukarıda elde edilen veri ile sütun grafiği oluşturlması işlemi. 

new_plot <- f_spc_data %>% ggplot(aes(x = reps , y = Country, fill = Country)) + 
  geom_bar(stat = "identity") +
  theme_bw() #x ekseninde ülkelerin tekrar sayısını ve y ekseninde ülkeleri içeren renkli sütun grafiğinin oluşturulması işlemi. 
new_plot

#Hareketsiz olan sütun grafiğinin animasyonlu hale geçirilmesi işlemi
#İşlem başladıktan sonra durdurulmamalıdır, render alma işlemi sistem özelliklerinize göre değişken zaman almaktadır. 

new_animation <- new_plot + transition_states(MonthName, transition_length = 2, state_length = 0) +
  labs(title = "Animated Visualisation of Variant Data COVID-19", 
       subtitle ='Month: {closest_state}') #Yukarıda faktör cinsinden belirtilen ay isimlerine göre hareketsiz sütun grafiğine animasyon eklenmesi işlemi. 
new_animation


#Animasyonun çözünürlüğü ve saniye başına kare gösterimi ayarlarının son halinin belirlenmesi işlemi. 
animate(new_animation, width = 600, height = 300, fps = 20)

vfinal_animation <- animate(new_animation, height = 500, width = 800, fps = 30, duration = 10,
        end_pause = 60, res = 100, renderer = gifski_renderer())

anim_save("covid-19_variant.gif", vfinal_animation) #Son olarak elde edilen animasyonun gif dosyası olarak kaydedilmesi. 


























  
  
  
  
  
  
  
  

  
