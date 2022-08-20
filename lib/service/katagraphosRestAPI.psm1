# file katagraphosRestAPI.psm1

function GetVersion {
    return "1.0.0"
}

function GetPSScriptRoot
{
    return $PSScriptRoot
}


function InvokeFilechecker  {
 
    # param($worksheetName , $fileExt = ".xlsx")

    # if ($worksheetName -cmatch '\.[^.]+$') {
    #     # worksheetName has a file extesnion .xlsx
    #     $extension = $matches[0]
    #     if ($extension -EQ $fileExt) {
    #         #good nothing to do
    #     }
    #     else {
    #         throw "odd file extension, $extension, either provide no extension, or use .xlsx"
    #     }
    # }
    # else {
    #     #no ext add xlsx
    #     return "$worksheetName.xlsx"
    # }

    return "dox.xls"
}