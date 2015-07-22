// Common Colors //

@land: #e4ddd3;
//@water: #ddedf4;
@water: #cdd6f2;
@water_dark: #185869;  // for the inline/shadow
//@crop: #d7debf;
//@grass: #d7debf;
//@scrub: #cad7b5;
//@wood: #c0d0ac;
@crop: #e3f2ce;
//@crop: #daecc3;
@grass: #daecc3;
//@grass: #d2e6b8;
@scrub: #d2e6b8;
@wood: #c9dfad;
//@wood: #c9dfad;
@snow: #e8eefa;
@rock: #c8d3cb;
@sand: mix(#e0d7c3,@land,33%);
// These colors need to take `comp-op:multiply` into account:
@cemetery: #edf4ed;
@pitch: fadeout(#fff,50%);
@park: #edf9e4;
@piste: mix(blue,@land,5);
@school: #fbf6ff;
@hospital: #fff0f0;
@builtup: #f6faff;

// Colors used in Mapbox Streets//
/*@land:              #E8E0D8;
@water:             #73B6E6;
@grass:             #E1EBB0;
@sand:              #F7ECD2;
@rock:              #D8D7D5;
@park:              #C8DF9F;
@cemetery:          #D5DCC2;
@wood:              #B0C89F;
@industrial:        #DDDCDC;
@agriculture:       #EAE0D0;
@snow:              #EDE5DD;
@crop:              #E9E5C2;
@building:          darken(@land, 8);
@hospital:          #F2E3E1;
@school:            #F2EAB8;
@pitch:             #CAE6A9;
@sports:            @park; */

// Background //

Map {
  background-color: @land;
  font-directory: url("fonts/");
}

// Mapbox Terrain global landcover //

#landcover {
  [class='wood'] { polygon-fill: @scrub; }
  [class='scrub'] { polygon-fill: @scrub; }
  [class='grass'] { polygon-fill: @scrub; }
  [class='crop'] { polygon-fill: @scrub; }
  [class='snow'] { polygon-fill: @snow; }
  // fade out stronger classes at high zooms,
  // let more detailed OSM data take over a bit:
  [class='wood'][zoom>=14],
  [class='scrub'][zoom>=15],
  [class='grass'][zoom>=16] {
    [zoom>=14] { polygon-opacity: 0.8; }
    [zoom>=15] { polygon-opacity: 0.6; }
    [zoom>=16] { polygon-opacity: 0.4; }
    [zoom>=17] { polygon-opacity: 0.2; }
  }
}

// OSM landuse & landcover //

/*#landuse {
  // The ::cover attachments fade in and become solid, overriding
  // any underlying shaped in the #landcover layer.
  ::cover33 { opacity: 0.33; }
  ::cover66 { opacity: 0.66; }
  ::cover33[zoom=13],
  ::cover66[zoom=14],
  ::cover[zoom>=15] {
    // Bring in OSM landcover only at higher zoom levels where
    // the higher level of detail makes sense.
    [class='wood'] { polygon-fill: @wood; }
    [class='scrub'] { polygon-fill: @scrub; }
    [class='grass'] { polygon-fill: @grass; }
    [class='crop'] { polygon-fill: @crop; }
    [class='sand'] { polygon-fill: @sand; }
    [type='golf_course'],[type='rough'] { polygon-fill: darken(@park,10); }
  }
  ::cover33[zoom=10],
  ::cover66[zoom=11],
  ::cover[zoom>=12] {
    [class='rock'] { polygon-fill: @rock; }
  }
}*/

// Hillshading //

/*#hillshade {
  ::0[zoom<=13],
  ::1[zoom=14],
  ::2[zoom>=15][zoom<=16],
  ::3[zoom>=17][zoom<=18],
  ::4[zoom>=19] {
    comp-op: hard-light;
    polygon-clip: false;
    image-filters-inflate: true;
    [class='shadow'] {
      polygon-fill: #513b16;
      polygon-comp-op: darken;
      //polygon-comp-op: multiply;
      [zoom>=0][zoom<=3] { polygon-opacity: 0.10; }
      [zoom>=4][zoom<=5] { polygon-opacity: 0.08; }
      [zoom>=6][zoom<=14] { polygon-opacity: 0.04; }
      [zoom>=15][zoom<=16] { polygon-opacity: 0.04; }
      [zoom>=17][zoom<=18] { polygon-opacity: 0.02; }
      [zoom>=18] { polygon-opacity: 0.01; }
    }
    [class='highlight'] {
      polygon-fill: #d9c49f;
      polygon-opacity: 0.2;
      [zoom>=15][zoom<=16] { polygon-opacity: 0.15; }
      [zoom>=17][zoom<=18] { polygon-opacity: 0.10; }
      [zoom>=18] { polygon-opacity: 0.05; }
    }
  }
  ::1 { image-filters: agg-stack-blur(2,2); }
  ::2 { image-filters: agg-stack-blur(8,8); }
  ::3 { image-filters: agg-stack-blur(16,16); }
  ::4 { image-filters: agg-stack-blur(32,32); }
}*/

// Water Features //

#water {
  //polygon-clip: false;
  //polygon-fill: @water_dark;
  ::blur {
    // A second attachment that is blurred creates the effect of
    // an inline stroke on the water layer.
    image-filters: agg-stack-blur(1,1);
    image-filters-inflate: true;
    polygon-clip: false;
    polygon-fill: @water;
    polygon-gamma: 0.6;
    [zoom<6] { polygon-gamma: 0.4; }
  }
}

#waterway {
  [type='river'],
  [type='canal'] {
    //line-color: mix(@water,@water_dark,60);
    line-color: @water;
    line-width: 0.5;
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; line-cap: round; line-smooth: 0.5; }
    [zoom>=16] { line-width: 3; }
  }
  [type='stream'] {
    line-color: mix(@water,@water_dark,60);
    line-width: 0.25;
    [zoom>=14] { line-width: 1; line-smooth: 0.5; }
    [zoom>=16] { line-width: 1.5; line-cap: round; }
    [zoom>=18] { line-width: 2; }
  }
}

// Political boundaries //

#admin {
  line-join: round;
  //line-color: #a1a1ab;
  line-color: #a7b398;
  [maritime=1] { line-color: darken(@water, 3%); }
  // Countries
  [admin_level=2] {
    [zoom=2] { line-width: 0.4; }
    [zoom=3] { line-width: 0.8; }
    [zoom=4] { line-width: 1; }
    [zoom=5] { line-width: 1.5; }
    [zoom>=6] { line-width: 2; }
    [zoom>=8] { line-width: 3; }
    [zoom>=10] { line-width: 4; }
    [disputed=1] { line-dasharray: 4,4; }
  }
  // States / Provices / Subregions
  [admin_level>=3] {
    line-width: 1;
    //line-dasharray: 10,3,3,3;
    [zoom>=6] { line-width: 1; }
    [zoom>=8] { line-width: 2; }
    [zoom>=12] { line-width: 3; }
  }
}