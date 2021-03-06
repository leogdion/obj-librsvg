//
//  RSVG.m
//  obj-librsvg
//
//  Created by Leo Dion on 9/21/17.
//  Copyright © 2017 Leo Dion. All rights reserved.
//

#import <librsvg/rsvg.h>
#import <cairo-pdf.h>

#import "RSVG.h"

@implementation RSVG
+ (void)createPNGFromSVG
{
  GError * error = nil;
  RsvgDimensionData dimensions;
  RsvgHandle * handle = rsvg_handle_new_from_file( "/Users/leo/Documents/Projects/obj-librsvg/obj_librsvgTests/geometry.svg", &error);
  rsvg_handle_get_dimensions(handle, &dimensions);
  NSLog(@"%d %d", dimensions.width, dimensions.height);
  cairo_surface_t*  surface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, dimensions.width * 0.5, dimensions.height * 0.5);
  
  
  cairo_t* cr = cairo_create(surface);
  cairo_set_source_rgb (cr, 1, 0, 0);
  //cairo_rectangle (cr, 0, 0, dimensions.width * 0.5, dimensions.height * 0.5);
  cairo_paint(cr);

  cairo_scale(cr, 0.5, 0.5);
  BOOL result = rsvg_handle_render_cairo(handle, cr);
  cairo_status_t status = cairo_surface_write_to_png(surface, "/Users/leo/Documents/Projects/obj-librsvg/obj_librsvgTests/geometry.png");
}

+ (void)createPDFFromSVG
{
  
  GError * error = nil;
  RsvgDimensionData dimensions;
  RsvgHandle * handle = rsvg_handle_new_from_file( "/Users/leo/Documents/Projects/obj-librsvg/obj_librsvgTests/geometry.svg", &error);
  rsvg_handle_get_dimensions(handle, &dimensions);
  NSLog(@"%d %d", dimensions.width, dimensions.height);
  cairo_surface_t*  surface = cairo_pdf_surface_create("/Users/leo/Documents/Projects/obj-librsvg/obj_librsvgTests/geometry.pdf",dimensions.width * 0.5, dimensions.height * 0.5);
  
  cairo_t* cr = cairo_create(surface);
  cairo_scale(cr, 0.5, 0.5);
  BOOL result = rsvg_handle_render_cairo(handle, cr);
  //cairo_status_t status = cairo_surface_write_to_png(surface, "/Users/leo/Documents/Projects/obj-librsvg/obj_librsvgTests/geometry.png");
  cairo_destroy(cr);
  cairo_surface_destroy(surface);
}

+ (void)createPNGFromPNG
{
  
  
  cairo_surface_t*  sourceSurface = cairo_image_surface_create_from_png("/Users/leo/Documents/Projects/obj-librsvg/obj_librsvgTests/geometry.png");
  cairo_surface_t*  destinationSurface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, cairo_image_surface_get_width(sourceSurface) * 2, cairo_image_surface_get_height(sourceSurface) * 2);
  cairo_t* cr = cairo_create(destinationSurface);
  
  
  cairo_scale(cr, 2, 2);
  cairo_set_source_surface(cr, sourceSurface, 0, 0);
  cairo_paint(cr);
  cairo_status_t status = cairo_surface_write_to_png(destinationSurface, "/Users/leo/Documents/Projects/obj-librsvg/obj_librsvgTests/geometry@2x.png");
}
@end
