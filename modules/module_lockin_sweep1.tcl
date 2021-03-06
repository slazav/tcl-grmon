# An example of graphene::monitor module.
# Sweep voltage and measure signal by SR830 lock-in
package require Device

itcl::class lockin_sweep {
  inherit graphene::monitor_module

  variable dev

  constructor {} {
    set tmin   5
    set tmax   10
    set atol   0
    set name   "Lock-In sweeper"
    set cnames {F X Y}

    Device lockin

    set sweeper 1
    set smin 0.1
    set smax 5.0
    set ds 0.1
    set s0 0.1
    lockin write SLVL $s0
    after 2000
    set sdir 1
    set srun 1
    if {$s0 > $smax} {set sdir -1}
    if {$s0 < $smin} {set sdir +1}
  }


  method get {} {
    set U1 [regexp -all -inline {[^,]+} [lockin cmd OUTP? 3]]
    set U0 [lockin cmd SLVL?]
    set R0 1006000.0
    set R [expr {$R0*$U1/($U0-$U1)}]
    set W [expr {$U1*$U1/2.0/$R}]

    lockin write SLVL $s0
    return "$U0 $R $W"
  }
}
