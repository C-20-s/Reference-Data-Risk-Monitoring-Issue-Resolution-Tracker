Sub ExportClientDataIssues()
    Dim conn As Object, rs As Object, xlRow As Integer
    Dim sql As String
    Set conn = CreateObject("ADODB.Connection")
    Set rs = CreateObject("ADODB.Recordset")

    ' Update with your actual DB path
    conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\path\to\client_data.accdb;Persist Security Info=False;"

    sql = "SELECT * FROM data_quality_issues;"
    rs.Open sql, conn

    ' Output to Excel
    Sheets("Issues").Cells.Clear
    xlRow = 1

    ' Headers
    For i = 0 To rs.Fields.Count - 1
        Sheets("Issues").Cells(xlRow, i + 1).Value = rs.Fields(i).Name
    Next i
    xlRow = xlRow + 1

    ' Data
    Do Until rs.EOF
        For i = 0 To rs.Fields.Count - 1
            Sheets("Issues").Cells(xlRow, i + 1).Value = rs.Fields(i).Value
        Next i
        xlRow = xlRow + 1
        rs.MoveNext
    Loop

    rs.Close
    conn.Close
    MsgBox "Data Quality Issues Exported Successfully!", vbInformation
End Sub
