class cups::params ( $printerdriverdir = hiera ("cups::::params::printerdriverdir","puppet:///site_files/ppd") , 
                     $printers = hiera_array("cups::params::printers",[])
)
{}
                     
