' Developer: Brady Lange
' Date: 6/9/18
' This program rests colors of shape elements and resets text box's text using a collection to iterate through the elements.
' Language: Visual Basic (Visual Studio 2010)
' Elements: 
' ShapeContainers: ShapeContainerA, ShapeContainerB, ShapeContainerC
' Microsoft Powerpack Shapes: ShapeA1, ShapeA2, ShapeA3, ShapeB1, ShapeB2, ShapeB3, ShapeC1, ShapeC2
' Frames: TextFrame
' Textbox's: TextBox1, TextBox2, TextBox3, TextBox4

' Subroutine that resets the shapes and textbox's in the TextFrame to their default state.
Public Sub ResetProgram()

	' Reset shapes to default color
	Dim counter As Integer = 0
	For Each item As PowerPacks.Shape In ShapeContainerA.Shapes
		ShapeContainerA.Shapes.Item(I).BackColor = Color.Black
		ShapeContainerD.Shapes.Item(I).BackColor = Color.Black
		' The array of ShapeC doesn't need the full loop so disclude the element afte two times through
		If I <= 1 Then
			ShapeContainerC.Shapes.Item(I).BackColor = Color.Black
		End If
		counter += 1
	Next

	' Reset counter to 0
	counter = 0
	' Reset text box's
	For Each item As Control In TextFrame.Controls
		TextFrame.Controls.Item(I).Text = "---"
		If counter = 3 Then
			Exit For
		End If
		counter += 1
	Next

End Sub
