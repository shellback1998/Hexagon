Attribute VB_Name = "HScroll"
Option Explicit

Private Const LB_SETHORIZONTALEXTENT = &H194
Private Type TEXTMETRIC
        tmHeight As Long
        tmAscent As Long
        tmDescent As Long
        tmInternalLeading As Long
        tmExternalLeading As Long
        tmAveCharWidth As Long
        tmMaxCharWidth As Long
        tmWeight As Long
        tmOverhang As Long
        tmDigitizedAspectX As Long
        tmDigitizedAspectY As Long
        tmFirstChar As Byte
        tmLastChar As Byte
        tmDefaultChar As Byte
        tmBreakChar As Byte
        tmItalic As Byte
        tmUnderlined As Byte
        tmStruckOut As Byte
        tmPitchAndFamily As Byte
        tmCharSet As Byte
End Type

Private Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetTextMetrics Lib "gdi32" Alias "GetTextMetricsA" (ByVal hdc As Long, lpMetrics As TEXTMETRIC) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long

Private Sub HScroll(ListBoxControl As ListBox, iMaxStringLen As Integer)

    Dim tm As TEXTMETRIC
    Dim ListDC As Long
    Dim lbhwnd As Long
    Dim status As Long
    Dim ExtraPixels As Long

    lbhwnd = ListBoxControl.hwnd
    ListDC = GetDC(lbhwnd)
    status = GetTextMetrics(ListDC, tm)
    ExtraPixels = tm.tmAveCharWidth * iMaxStringLen
    
    'Add the scroll bar.
    status = SendMessage(lbhwnd, LB_SETHORIZONTALEXTENT, ExtraPixels, 0&)

End Sub

Private Function GetMaxStringLenInListControl(Listcontrol As ListBox) As Integer
    
    Dim i As Integer
    Dim iMaxLen As Integer
    Dim iCurLen As Integer
    
    For i = 0 To Listcontrol.ListCount
        iCurLen = Len(Listcontrol.List(i))
        If (iCurLen > iMaxLen) Then
            iMaxLen = iCurLen
        End If
    Next i
    
    GetMaxStringLenInListControl = iMaxLen
    
End Function

Public Sub ResetHScrollBar(Listcontrol As ListBox)

    Dim iMaxLeftStringLen As Integer
    
    iMaxLeftStringLen = GetMaxStringLenInListControl(Listcontrol)
    Call HScroll(Listcontrol, iMaxLeftStringLen)
    
End Sub


