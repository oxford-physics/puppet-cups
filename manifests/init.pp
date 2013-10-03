class cups ( $printernames = $cups::params::printernames, 
	     $printerdriverdir= $cups::params::printerdriveridir,  
) inherits cups::params
{


   define addprinter($printerdriverdir) {
       $printersconf = "/etc/cups/printers.conf"
       exec { "add-printer $name":
           unless => ["grep ${name} ${printersconf} >/dev/null "],
           path => ['/usr/bin', '/usr/local/bin', '/bin', '/sbin' , '/usr/sbin'],
           require => File["/usr/local/bin/add-printer"],
           notify => Service["cups"]
       }
       file { "/etc/cups/ppd/$name.ppd":
              ensure => present,
              source => "$printerdriverdir/${name}.ppd"
            }
   

}
   file { "/usr/local/bin/add-printer":
              ensure => present,
              source => "puppet:///modules/cups/add-printer",
              owner=>root,
              group=>root,
              mode=>0744
   }
   addprinter{ $printers : printerdriverdir => $printerdriverdir}
   ensure_packages ( ["cups"] )   
   service { "cups": 
              ensure  => running,
              enable     => true,
              hasrestart => true,
              hasstatus  => true,
              require    => Package['cups'],
           }

}

