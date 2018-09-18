from tkinter import *
import barcode
from barcode.writer import ImageWriter
import qrcode
qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=10,
    border=4,
)
#  程式一執行產生輸入帳號密碼介面
win=Tk()


#全域帳號、密碼、THREAD數
Barcodestring = None

# cancel按鈕的事件
def FormClose():
    win.destroy()
    exit()
# ok按鈕的事件
def FormOK(edit_barcode):
    global Barcodestring
    Barcodestring = edit_user.get()
    name=edit_save.get().strip()+'.png'
    #qr.add_data(Barcodestring)
    #qr.make(fit=True)
    #img = qr.make_image(fill_color="black", back_color="white")
    #img.save(name)
    EAN = barcode.get_barcode_class('code39')
    ean = EAN(Barcodestring, writer=ImageWriter(),add_checksum=False)
    f = open(name, 'wb')
    ean.write(f)
    f.close()
    photo=PhotoImage(file=name)
    edit_barcode.configure(image=photo)
    edit_barcode.image=photo


    
#Barcode介面設定
win.title("Barcode 生成器")
win.geometry("500x500")

#輸入要轉換的Barcode
label_user=Label(win, text="請輸入轉換碼(限英文)")
edit_user=Entry(win, text="")
label_user.grid(column=0, row=0)
edit_user.grid(column=1, row=0, columnspan=15)
#輸入要儲存的檔名
label_save=Label(win, text="請輸入檔名(可中文)")
edit_save=Entry(win, text="")
label_save.grid(column=0, row=1)
edit_save.grid(column=1, row=1, columnspan=15)
#Barcode 照片
label_barcode=Label(win, text="barcode :")
label_barcode.grid(column=0, row=2)
edit_barcode=Label(win, text='')
edit_barcode.grid(column=0, row=3,columnspan=5)
#BUTTON-連接事件
button_cancel = Button(win, text="結束",  width="15", command=FormClose)
button_ok = Button(win, text="轉換",width="15", command=lambda: FormOK(edit_barcode))
button_cancel.grid(column=1, row=4)
button_ok.grid(column=0, row=4)
win.mainloop()
