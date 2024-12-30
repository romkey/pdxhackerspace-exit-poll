// PDX Hackerspace Exit Poll
// https://www.aliexpress.us/item/3256802965763349.html
// https://www.aliexpress.us/item/3256804835346770.html
$fn = 60;

render_stl = 0;
// 3.5"
// display_width = 56;
// display_height = 98;

// 4.0"
display_width = 61.74;
display_height = 108.4;

hole_radius = 2.5; //3.42;
hole_width_offset = 3.42;
hole_height_offset = 3;

bottom_margin = 6.5;
top_margin = 6.54;


// "active area" 48.96x73.44(mm)
//active_width = 48.96;
//active_height = 73.44;

led_width = display_width;
led_height = display_height - bottom_margin - top_margin;

case_width = display_width + 10;
case_height = display_height + 10;
case_depth = 25;

thickness = 2;

screw_hole_diameter = 5/32*25.4 + 1;;

catch_height = 4;
catch_width = 8;

usb_cutout_width = 20;
usb_cutout_height = 8;

module catch() {
    cube([thickness, catch_width, catch_height]);
    translate([-1, 0, catch_height])
      cube([thickness + 1, catch_width, 2]);
}

module cover() {
difference() {
    union() {
      cube([case_width, case_height, thickness*2]);
      translate([-thickness, -thickness, 0])
        cube([case_width + thickness*2, case_height + thickness*2, thickness]);
      }

    translate([(case_width - led_width)/2, bottom_margin+5, 0])
      cube([led_width, led_height, thickness*2]);
    translate([5 + hole_width_offset, 5 + hole_height_offset, 0])
      cylinder(h = thickness*2, r = hole_radius);
    translate([5 + hole_width_offset, case_height - (5 + hole_height_offset), 0])
      cylinder(h = thickness*2, r = hole_radius);
    translate([case_width - (5 + hole_width_offset), 5 + hole_height_offset, 0])
      cylinder(h = thickness*2, r = hole_radius);
    translate([case_width - (5 + hole_width_offset), case_height - (5 + hole_height_offset), 0])
      cylinder(h = thickness*2, r = hole_radius);
      
    // LED hole
  }
  
  module left_side_catches(){
      translate([thickness, case_height/4, thickness*2]) {
          catch();
      }
      translate([thickness, 3*case_height/4, thickness*2]) {
          catch();
      }
  }
  
  //Build the left side
  left_side_catches();
  
  //Then the right (with mirroring)
  translate([case_width, 0,0]) mirror([1,0,0]) {
     left_side_catches();
  }
 
  //Cut out a slot for the touchscreen header pins to sit in
  top_to_center_pin_distance = 6.5;
  translate([case_width/2, case_height-top_to_center_pin_distance, (thickness*2)-0.5]){
    cube([39,3,3],true);
  }
  

}

module box() {
    difference() {
      cube([case_width + thickness*2, case_height+thickness*2, case_depth+thickness*2]);

      translate([thickness, thickness, thickness])
        cube([case_width, case_height, case_depth + thickness]);
      translate([thickness + case_width/10, thickness + case_height/10, 0])
        cube([8*case_width/10, 8*case_height/10, thickness]);

      translate([thickness + case_width/3, thickness + case_height*19/20, 0])
        cylinder(h = thickness*2, d = screw_hole_diameter);

      translate([thickness + case_width/3 - screw_hole_diameter/2, thickness + case_height*18/20, 0])
        cube([screw_hole_diameter, case_height/20, thickness]);

      translate([thickness + 2*case_width/3, thickness + case_height*19/20, 0])
        cylinder(h = thickness*2, d = screw_hole_diameter);
      translate([thickness + 2*case_width/3 - screw_hole_diameter/2, thickness + case_height*18/20, 0])
        cube([screw_hole_diameter, case_height/20, thickness]);
        
      translate([(case_width + thickness*2 - usb_cutout_width)/2, 0, case_depth/4])
        cube([usb_cutout_width, thickness, usb_cutout_height]);
    }

    translate([thickness, thickness + case_height/4, thickness+case_depth-catch_height])
      cube([thickness, catch_width, catch_height]);
     translate([thickness, thickness + 3*case_height/4, thickness+case_depth-catch_height])
      cube([thickness, catch_width, catch_height]); 
    translate([case_width, thickness + case_height/4, thickness+case_depth-catch_height])
      cube([thickness, catch_width, catch_height]);
     translate([case_width, thickness + 3*case_height/4, thickness+case_depth-catch_height])
      cube([thickness, catch_width, catch_height]); 
}

module box_big_notch() {
    difference() {
      cube([case_width + thickness*2, case_height+thickness*2, case_depth+thickness*2]);

      // hollow out the inside of the box
      translate([thickness, thickness, thickness])
        cube([case_width, case_height, case_depth + thickness]);

      // save filament by cutting out most of the back panel
      translate([thickness + case_width/10, thickness + case_height/10, 0])
        cube([8*case_width/10, 8*case_height/10, thickness]);

      // knockouts for hanging the box on screws
      translate([thickness + case_width/3, thickness + case_height*19/20, 0])
        cylinder(h = thickness*2, d = screw_hole_diameter);
      translate([thickness + case_width/3 - screw_hole_diameter/2, thickness + case_height*18/20, 0])
        cube([screw_hole_diameter, case_height/20, thickness]);
      translate([thickness + 2*case_width/3, thickness + case_height*19/20, 0])
        cylinder(h = thickness*2, d = screw_hole_diameter);
      translate([thickness + 2*case_width/3 - screw_hole_diameter/2, thickness + case_height*18/20, 0])
        cube([screw_hole_diameter, case_height/20, thickness]);
        
      // USB cable knockout
      translate([(case_width + thickness*2)/2, 0, case_depth/4])
        cube([case_width/2, thickness, case_depth/2]);

      // knockout for LED cables
//      translate([(case_width- 10 + thickness)/2, case_height+thickness, case_depth + thickness*2 - 10])
//        cube([10, thickness, 10]);
    }

    translate([thickness, thickness + case_height/4, thickness+case_depth-catch_height])
      cube([thickness, catch_width, catch_height]);
     translate([thickness, thickness + 3*case_height/4, thickness+case_depth-catch_height])
      cube([thickness, catch_width, catch_height]); 
    translate([case_width, thickness + case_height/4, thickness+case_depth-catch_height])
      cube([thickness, catch_width, catch_height]);
     translate([case_width, thickness + 3*case_height/4, thickness+case_depth-catch_height])
      cube([thickness, catch_width, catch_height]); 
}

module base() {
    d = case_height + thickness*4;
    translate([d*.5/4, d*1.5/3, 0])
      linear_extrude(thickness) {
        scale([.5, 1.5])
          circle(d = d);
    }    

  translate([0, 0, thickness])
  difference() {
    cube([case_depth + thickness*5, case_height + thickness*4, 7]);
    translate([thickness, thickness, 0])
      cube([case_depth + thickness*3, case_height + thickness*2, 7]);
  }
}


// Render the case and box side by side about origin for easy viewing
module main(){
    translate([-(case_width*1.2), 0, 0]){
        box_big_notch();
    }

    translate([(case_width*0.2), 0, 0]){
        cover();
    }
}

//Hack to render a specific part
// Use openscad -D render_stl=# -o <outfile> exit-poll.scad to render a specific part
if(render_stl==0)
    main();
if(render_stl==1)
    box_big_notch();
if(render_stl==2)
    cover();

