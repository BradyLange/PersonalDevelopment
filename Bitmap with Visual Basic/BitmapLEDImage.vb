Public Class BitmapLEDImage 

	' Developed by Brady Lange
	' Date: 6/6/18
	' Language: Visual Basic (Visual Studio 2010)
	' Purpose: Bitmap format an image (PictureBox element) 
	' Visual Studio Elements:
	' - PicACM is a PictureBox element

	' Global Variables: 
	' Step number
	Dim StepNum As Integer
	' ResetFlag is a condition to reset the LED colors
	Dim ResetFlag As Boolean = False

	' LEDs for bitmap on the image
	Dim img As Image = Image.FromFile("C:\image.bmp")
	Dim BMP As New Bitmap(img)
	
	' A graphic for each LED
	Dim GFXLogicOnLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXStartInpLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXSVLLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXSVRLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXSVQLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXHeadLowLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXHeadHighLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXTransportLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXAERateLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXAutoLED As Graphics = Graphics.FromImage(BMP)
	Dim GFXOKLED As Graphics = Graphics.FromImage(BMP)
	
	' Properties for outline and creating the graphics (Rectangle = location of shape, Pen = Border of graphic)
	Dim LEDPen As Pen
	Dim LogicOnRec As Rectangle
	Dim StartInRec As Rectangle
	Dim SVLRec As Rectangle
	Dim SVRRec As Rectangle
	Dim SVQRec As Rectangle
	Dim HeadLowRec As Rectangle
	Dim HeadHighRec As Rectangle
	Dim TransportRec As Rectangle
	Dim AERateRec As Rectangle
	Dim AutoRec As Rectangle
	Dim OkRec As Rectangle
	
	' Properties for filling in the graphics with color
	Dim LEDColorReset As Brush = Brushes.White
	Dim LEDColorYellow As Brush = Brushes.Yellow
	Dim LEDColorRed As Brush = Brushes.Red

	' Form Load Event:
	Public Sub BitmapLEDImage_Load(ByVal sender As System.Object, ByVAl e As System.EventArgs) Handles MyBase.Load
		' Initializing the graphics for the Bitmap image
		PicACM.Image = BMP
		InitBMPGraphics()
		' Fire up the program
		Main()
	End Sub

	'Main Method to to execute the programs behaviors of manipulating LED color
	Public Sub Main()
		Step0:
			' Logic On LED
			StepNum = 0 
			FillLED()
		Step1:
			StepNum = 1
			FillLED()
		Step2:
			StepNum = 2
			FillLED()
		Step3:
			StepNum = 3
			FillLED()
		Step4:
			StepNum = 4
			FillLED()
		Step5:
			StepNum = 5
			FillLED()
		Step6:
			StepNum = 6
			FillLED()

			' Reset the LEDs
			ResetFlag = True
			FillLED()
	End Sub

	' Helper Methods:
	' Fills the LED based upon step
	Private Sub FillLED()
		Select Case StepNum Or ResetFlag
		    Case 0
			' Step 0 turn Logic On LED (color = red)
			FillEllipseRed(False)
			Application.DoEvents()
		    Case 1
			' Step 1 All = OC
			FillEllipseWhite(True)
			Application.DoEvents()
			Pause(1)
			FillEllipseWhite(False)
			FillEllipseYellow(False)
			Application.DoEvents()
		    Case 2
			' Step 2 Head High = GND, Head low = GND, Transport = GND, Aerate = GND, Auto = GND
			FillEllipseYellow(False)
			FillEllipseWhite(True)
			Application.DoEvents()
			Pause(0.5)
			FillEllipseWhite(False)
			Application.DoEvents()
		    Case 3
			' Step 3 Head High = GND, Head low = GND, Transport = GND, Aerate = GND, OKLower = GND, Auto = GND
			FillEllipseYellow(True)
			Application.DoEvents()
			FillEllipseYellow(False)
			FillEllipseWhite(False)
			Application.DoEvents()
		    Case 4
			' Step 4 Aerate = GND, OKLower = GND, Auto = GND
			FillEllipseWhite(True)
			FillEllipseYellow(False)
			Application.DoEvents()
			Pause(0.5)
			FillEllipseWhite(False)
			Application.DoEvents()
		    Case 5
			' Step 5 OKLower = GND, Auto = GND
			FillEllipseWhite(True)
			FillEllipseYellow(True)
			Application.DoEvents()
			Pause(0.5)
			FillEllipseYellow(False)
			FillEllipseWhite(False)
			Application.DoEvents()
		    Case 6
			' Step 6 OKLower = GND, Aerate = GND
			FillEllipseWhite(True)
			FillEllipseYellow(True)
			Application.DoEvents()
			Pause(0.5)
			FillEllipseYellow(False)
			FillEllipseWhite(False)
			Application.DoEvents()
		    Case True
			' Reset all of the LEDs to White color
			ResetLEDColors()
		    Case Else
			' If none of the cases are met, an error has occured (most likely with the StepNum variable)
			Text1.Text = "An Error has occured: Incorrect Step Value (Variable: StepNum). Contact your supervisor."
			Stop
		End Select
	End Sub

	' Fills conditioned object white
	Private Sub FillEllipseWhite(ByVal Yellow As Boolean)
		Select Case StepNum
		    Case 1
			' Step 1 All = OC
			If Yellow = True Then
			    GFXHeadHighLED.FillEllipse(LEDColorReset, HeadHighRec)
			    GFXHeadLowLED.FillEllipse(LEDColorReset, HeadLowRec)
			    GFXTransportLED.FillEllipse(LEDColorReset, TransportRec)
			    GFXAERateLED.FillEllipse(LEDColorReset, AERateRec)
			    GFXOKLED.FillEllipse(LEDColorReset, OkRec)
			    GFXAERateLED.FillEllipse(LEDColorReset, AutoRec)
			Else
			    ' Check SVL = OFF
			    GFXSVLLED.FillEllipse(LEDColorReset, SVLRec)
			End If
		    Case 2
			' Step 2 Head High = GND, Head low = GND, Transport = GND, Aerate = GND, Auto = GND
			If Yellow = True Then
			    GFXOKLED.FillEllipse(LEDColorReset, OkRec)
			Else
			    'Check ALL = OFF
			    GFXSVRLED.FillEllipse(LEDColorReset, SVRRec)
			    GFXSVLLED.FillEllipse(LEDColorReset, SVLRec)
			    GFXSVQLED.FillEllipse(LEDColorReset, SVQRec)
			End If
		    Case 3
			' Step 3 Head High = GND, Head low = GND, Transport = GND, Aerate = GND, OKLower = GND, Auto = GND
			' Check SVQ=OFF
			GFXSVQLED.FillEllipse(LEDColorReset, SVQRec)
		    Case 4
			' Step 4 Aerate = GND, OKLower = GND, Auto = GND
			If Yellow = True Then
			    GFXHeadHighLED.FillEllipse(LEDColorReset, HeadHighRec)
			    GFXHeadLowLED.FillEllipse(LEDColorReset, HeadLowRec)
			    GFXTransportLED.FillEllipse(LEDColorReset, TransportRec)
			Else
			    ' Check ALL OFF
			    GFXSVRLED.FillEllipse(LEDColorReset, SVRRec)
			    GFXSVLLED.FillEllipse(LEDColorReset, SVLRec)
			    GFXSVQLED.FillEllipse(LEDColorReset, SVQRec)
			End If
		    Case 5
			' Step 5 OKLower = GND, Auto = GND
			If Yellow = True Then
			    GFXHeadHighLED.FillEllipse(LEDColorReset, HeadHighRec)
			    GFXHeadLowLED.FillEllipse(LEDColorReset, HeadLowRec)
			    GFXTransportLED.FillEllipse(LEDColorReset, TransportRec)
			    GFXAERateLED.FillEllipse(LEDColorReset, AERateRec)
			Else
			    ' Check SVR=OFF
			    GFXSVRLED.FillEllipse(LEDColorReset, SVRRec)
			End If
		    Case 6
			' Step 6 OKLower = GND,Aerate = GND
			If Yellow = True Then
			    GFXHeadHighLED.FillEllipse(LEDColorReset, HeadHighRec)
			    GFXHeadLowLED.FillEllipse(LEDColorReset, HeadLowRec)
			    GFXTransportLED.FillEllipse(LEDColorReset, TransportRec)
			    GFXAERateLED.FillEllipse(LEDColorReset, AutoRec)
			Else
			    ' Check SVR = OFF, SVQ = OFF
			    GFXSVRLED.FillEllipse(LEDColorReset, SVRRec)
			    GFXSVQLED.FillEllipse(LEDColorReset, SVQRec)
			End If
		    Case Else
			' If none of the cases are met, an error has occured (most likely with the StepNum variable)
			Text1.Text = "An Error has occured: Incorrect Step Value (Variable: StepNum). Contact your supervisor."
			Stop
		End Select

	End Sub

	' Fills conditioned object yellow
	Private Sub FillEllipseYellow(ByVal White As Boolean)
		Select Case StepNum
		    Case 1
			' Step 1 All = OC
			' Check SVR = ON, SVQ = ON
			GFXSVRLED.FillEllipse(LEDColorYellow, SVRRec)
			GFXSVQLED.FillEllipse(LEDColorYellow, SVQRec)
		    Case 2
			' Step 2 Head High = GND, Head low = GND, Transport = GND, Aerate = GND, Auto = GND
			GFXHeadHighLED.FillEllipse(LEDColorYellow, HeadHighRec)
			GFXHeadLowLED.FillEllipse(LEDColorYellow, HeadLowRec)
			GFXTransportLED.FillEllipse(LEDColorYellow, TransportRec)
			GFXAERateLED.FillEllipse(LEDColorYellow, AERateRec)
			GFXAutoLED.FillEllipse(LEDColorYellow, AutoRec)
		    Case 3
			' Step 3 Head High = GND, Head low = GND, Transport = GND, Aerate = GND, OKLower = GND, Auto = GND
			If White = True Then
			    GFXHeadHighLED.FillEllipse(LEDColorYellow, HeadHighRec)
			    GFXHeadLowLED.FillEllipse(LEDColorYellow, HeadLowRec)
			    GFXTransportLED.FillEllipse(LEDColorYellow, TransportRec)
			    GFXAERateLED.FillEllipse(LEDColorYellow, AERateRec)
			    GFXOKLED.FillEllipse(LEDColorYellow, OkRec)
			    GFXAutoLED.FillEllipse(LEDColorYellow, AutoRec)
			Else
			    ' Check SVR = ON, SVL = ON
			    GFXSVRLED.FillEllipse(LEDColorYellow, SVRRec)
			    GFXSVLLED.FillEllipse(LEDColorYellow, SVLRec)
			End If
		    Case 4
			' Step 4 Aerate = GND, OKLower = GND, Auto = GND
			GFXAERateLED.FillEllipse(LEDColorYellow, AERateRec)
			GFXOKLED.FillEllipse(LEDColorYellow, OkRec)
			GFXAutoLED.FillEllipse(LEDColorYellow, AutoRec)
		    Case 5
			' Step 5 OKLower = GND, Auto = GND
			If White = True Then
			    GFXOKLED.FillEllipse(LEDColorYellow, OkRec)
			    GFXAutoLED.FillEllipse(LEDColorYellow, AutoRec)
			Else
			    ' Check SVL = ON, SVQ = ON
			    GFXSVLLED.FillEllipse(LEDColorYellow, SVLRec)
			    GFXSVQLED.FillEllipse(LEDColorYellow, SVQRec)
			End If
		    Case 6
			' Step 6 OKLower = GND, Aerate = GND
			If White = True Then
			    GFXAERateLED.FillEllipse(LEDColorYellow, AERateRec)
			    GFXOKLED.FillEllipse(LEDColorYellow, OkRec)
			Else
			    ' Check SVL = ON
			    GFXSVLLED.FillEllipse(LEDColorYellow, SVLRec)
			End If
		    Case Else
			' If none of the cases are met, an error has occured (most likely with the StepNum variable)
			Text1.Text = "An Error has occured: Incorrect Step Value (Variable: StepNum). Contact your supervisor."
			Stop
		End Select
	End Sub

	' Fills object red
	Private Sub FillEllipseRed(ByVal NotRed As Boolean)
		GFXLogicOnLED.FillEllipse(LEDColorRed, LogicOnRec)
	End Sub

	' Initailizing the graphics for the bitmap image (color, size, coordinates)
	Private Sub InitBMPGraphics()
		' Creating graphic components (pen = pen color, pen size & rectangle = size) for the Bitmap of the ACM image
			' Location of the Rectangle will be based upon your images width (x) and height (y)
			' Pen color and size can be altered based upon preference
		LEDPen = New Pen(Color.Black, 3)
		' LogicOnLED
		LogicOnRec = New Rectangle(PicACM.Image.Size.Width - 400, PicACM.Image.Size.Height - 321, 24, 21)
		' StartInLED
		StartInRec = New Rectangle(PicACM.Image.Size.Width - 400, PicACM.Image.Size.Height - 245, 24, 21)
		' SVLLED
		SVLRec = New Rectangle(PicACM.Image.Size.Width - 400, PicACM.Image.Size.Height - 215, 24, 21)
		' SVRLED
		SVRRec = New Rectangle(PicACM.Image.Size.Width - 400, PicACM.Image.Size.Height - 180, 24, 21)
		' SVQLED
		SVQRec = New Rectangle(PicACM.Image.Size.Width - 400, PicACM.Image.Size.Height - 145, 24, 21)

		' HeadLowLED
		HeadLowRec = New Rectangle(PicACM.Image.Size.Width - 78, PicACM.Image.Size.Height - 321, 24, 21)
		' HeadHighLED
		HeadHighRec = New Rectangle(PicACM.Image.Size.Width - 78, PicACM.Image.Size.Height - 287, 24, 21)
		' TransportLED
		TransportRec = New Rectangle(PicACM.Image.Size.Width - 78, PicACM.Image.Size.Height - 250, 24, 21)
		' AERateLED
		AERateRec = New Rectangle(PicACM.Image.Size.Width - 78, PicACM.Image.Size.Height - 215, 24, 21)
		' AutoLED
		AutoRec = New Rectangle(PicACM.Image.Size.Width - 78, PicACM.Image.Size.Height - 180, 24, 21)
		' OKLED
		OkRec = New Rectangle(PicACM.Image.Size.Width - 78, PicACM.Image.Size.Height - 140, 24, 21)

		' Drawing the outline of the ellipse
		' LogicOnLED
		GFXLogicOnLED.DrawEllipse(LEDPen, LogicOnRec)
		' StartInLED
		GFXStartInpLED.DrawEllipse(LEDPen, StartInRec)
		' SVLLED
		GFXSVLLED.DrawEllipse(LEDPen, SVLRec)
		' SVRLED
		GFXSVRLED.DrawEllipse(LEDPen, SVRRec)
		' SVQLED
		GFXSVQLED.DrawEllipse(LEDPen, SVQRec)
		' HeadLowLED
		GFXHeadLowLED.DrawEllipse(LEDPen, HeadLowRec)
		' HeadHighLED
		GFXHeadHighLED.DrawEllipse(LEDPen, HeadHighRec)
		' TransportLED
		GFXTransportLED.DrawEllipse(LEDPen, TransportRec)
		' AERateLED
		GFXAERateLED.DrawEllipse(LEDPen, AERateRec)
		' AutoLED
		GFXAutoLED.DrawEllipse(LEDPen, AutoRec)
		' OKLED
		GFXOKLED.DrawEllipse(LEDPen, OkRec)

		Reset:
			' Resetting all of the LEDs color to White (filling in the ellipse)
			ResetLEDColors()
	End Sub

	' Resets all of the LEDs colors to White
	Private Sub ResetLEDColors()
		' Resetting all of the LEDs color to White (filling in the ellipse)
		GFXLogicOnLED.FillEllipse(LEDColorReset, LogicOnRec)
		GFXStartInpLED.FillEllipse(LEDColorReset, StartInRec)
		GFXSVLLED.FillEllipse(LEDColorReset, SVLRec)
		GFXSVRLED.FillEllipse(LEDColorReset, SVRRec)
		GFXSVQLED.FillEllipse(LEDColorReset, SVQRec)
		GFXHeadLowLED.FillEllipse(LEDColorReset, HeadLowRec)
		GFXHeadHighLED.FillEllipse(LEDColorReset, HeadHighRec)
		GFXTransportLED.FillEllipse(LEDColorReset, TransportRec)
		GFXAERateLED.FillEllipse(LEDColorReset, AERateRec)
		GFXAutoLED.FillEllipse(LEDColorReset, AutoRec)
		GFXOKLED.FillEllipse(LEDColorReset, OkRec)
		ResetFlag = False
	End Sub


End Class
