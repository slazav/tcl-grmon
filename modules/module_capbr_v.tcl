# Monitoring Capacitance bridge
package require Device

itcl::class capbr_v {
  inherit graphene::monitor_module
  variable voltages {0.10 0.25 0.75 1.5 3.0 7.5 15.0}
  variable dev

  constructor {} {
    set dbname capbr_volt
    set tmin   1
    set tmax   10
    set atol   {}
    set name   "Cap.br (multiple voltages)"
    set cnames {0.10V 0.25V 0.75V 1.5V 3.0V 7.5V 15.0V}
    Device capbr
  }

  method start {} {
    $dev write "AV 4"
    $dev write "AL 0"
  }

  method get {} {
    set ret {}
    foreach v $voltages {
      capbr write VOLT $v
      regexp {([0-9\.]+)} [capbr cmd SH VOLT] volt
      set res [regexp -all -inline {\S+} [capbr cmd SI] ]
      set cap [lindex $res 1]
      set los [lindex $res 4]
      if {![regexp {^[\d\.]+$} $cap]} {set cap 0; set los 0}
      lappend ret $volt
      lappend ret $cap
      lappend ret $los
    }
    return $ret
  }
}
