# R package sticker generation

# Save as an svg. 
# Open in powerpoint
# Go to graphics format
# Conver to shape
# Modify whatever you want
# Make the font K2D
# You can make the letters a gradient to match the aesthetics of other

library(hexSticker)

imgurl <- "/users/mike/Desktop/RGenEDA/img/Picture1.png"
url <- "github.com/mikemartinez99/RGenEDA"

sticker(imgurl, package="RGenEDA", 
        p_size=8, 
        p_color = "black",
        s_x=1, 
        s_y=0.75, 
        s_width=.6, 
        s_height = 0.2, 
        asp = 0.8,
        h_color = "#00703C",
        url = url,
        u_size = 0.8,
        filename="/users/mike/Desktop/RGenEDA_Sticker.svg", h_fill = "white",
        dpi = 500)
