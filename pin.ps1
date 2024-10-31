#================================================
# Window Functions
# Minimize Command and PowerShell Windows
#================================================
$Script:showWindowAsync = Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@ -Name "Win32ShowWindowAsync" -Namespace Win32Functions -PassThru
function Hide-CmdWindow() {
    $CMDProcess = Get-Process -Name cmd -ErrorAction Ignore
    foreach ($Item in $CMDProcess) {
        $null = $showWindowAsync::ShowWindowAsync((Get-Process -Id $Item.id).MainWindowHandle, 2)
    }
}
function Hide-PowershellWindow() {
    $null = $showWindowAsync::ShowWindowAsync((Get-Process -Id $pid).MainWindowHandle, 2)
}
function Show-PowershellWindow() {
    $null = $showWindowAsync::ShowWindowAsync((Get-Process -Id $pid).MainWindowHandle, 10)
}
Hide-CmdWindow
Hide-PowershellWindow

### Creating the form with the Windows forms namespace
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Enter the code for the tenant' ### Text to be displayed in the title
$form.Size = New-Object System.Drawing.Size(310,250) ### Size of the window
$form.StartPosition = 'CenterScreen'  ### Optional - specifies where the window should start
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow  ### Optional - prevents resize of the window
$form.Topmost = $true  ### Optional - Opens on top of other windows

### Adding an OK button to the text box window
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(110,125) ### Location of where the button will be
$OKButton.Size = New-Object System.Drawing.Size(75,23) ### Size of the button
$OKButton.Text = 'OK' ### Text inside the button
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

### Adding a Cancel button to the text box window
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(70,550) ### Location of where the button will be
$CancelButton.Size = New-Object System.Drawing.Size(75,23) ### Size of the button
$CancelButton.Text = 'Cancel' ### Text inside the button
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

### Putting a label above the text box
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10) ### Location of where the label will be
$label.AutoSize = $True
$Font = New-Object System.Drawing.Font("Arial",14,[System.Drawing.FontStyle]::Bold) ### Formatting text for the label
$label.Font = $Font
$label.Text = $Input_Type ### Text of label, defined by the parameter that was used when the function is called
$label.ForeColor = 'Red' ### Color of the label text
$form.Controls.Add($label)

### Inserting the text box that will accept input
$textBox = New-Object System.Windows.Forms.TextBox
$Font = New-Object System.Drawing.Font("Arial",16,[System.Drawing.FontStyle]::Bold)
$textBox.Location = New-Object System.Drawing.Point(100,40) ### Location of the text box
$textBox.Size = New-Object System.Drawing.Size(75,150) ### Size of the text box
$textBox.Multiline = $false ### Allows multiple lines of data
$textBox.Font = $Font
$textbox.AcceptsReturn = $false ### By hitting enter it creates a new line
#$textBox.ScrollBars = "Vertical" ### Allows for a vertical scroll bar if the list of text is too big for the window
$form.Controls.Add($textBox)

$form.Add_Shown({$textBox.Select()}) ### Activates the form and sets the focus on it
$result = $form.ShowDialog() ### Displays the form 
  
### If the OK button is selected do the following
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    ### Removing all the spaces and extra lines
    $x = $textBox.Lines | Where{$_} | ForEach{ $_.Trim() }
    ### Putting the array together
    $array = @()
    ### Putting each entry into array as individual objects
    $array = $x -split "`r`n"
    ### Sending back the results while taking out empty objects
    Return $array | Where-Object {$_ -ne ''}
}
Show-PowershellWindow

### If the cancel button is selected do the following
if ($result -eq [System.Windows.Forms.DialogResult]::Cancel)
{
    Write-Host "User Canceled" -BackgroundColor Red -ForegroundColor White
    Write-Host "Press any key to exit..."
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    #Exit
}
