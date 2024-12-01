import ezdxf
from ezdxf import units

class ElevationDrawing:
    def __init__(self, filename="elevation.dxf"):
        # Create a new DXF document
        self.doc = ezdxf.new("R2010")
        self.doc.units = units.MM  # Set units to millimeters
        self.msp = self.doc.modelspace()
        
        # Create layers
        self.create_layers()
        
        # Default dimensions
        self.dimensions = {
            'wall_length': 9000,
            'wall_height': 3000,
            'eave_extension': 600,
            'door_width': 900,
            'door_height': 2100,
            'door1_position': 600,
            'door2_position': 6500,
            'window_width': 1200,
            'window_height': 1200,
            'window_sill_height': 900,
            'window1_position': 2500,
            'window2_position': 4500
        }
        
    def create_layers(self):
        # Create layers with different colors
        self.doc.layers.new("WALL", dxfattribs={'color': 7})  # White
        self.doc.layers.new("DOOR", dxfattribs={'color': 1})  # Red
        self.doc.layers.new("WINDOW", dxfattribs={'color': 4})  # Cyan
        self.doc.layers.new("EAVE", dxfattribs={'color': 3})  # Green
        self.doc.layers.new("DIMENSION", dxfattribs={'color': 2})  # Yellow
        
    def draw_wall(self):
        points = [
            (0, 0),
            (self.dimensions['wall_length'], 0),
            (self.dimensions['wall_length'], self.dimensions['wall_height']),
            (0, self.dimensions['wall_height']),
            (0, 0)
        ]
        self.msp.add_lwpolyline(points, dxfattribs={'layer': 'WALL'})
        
    def draw_eave(self):
        self.msp.add_line(
            (-self.dimensions['eave_extension'], self.dimensions['wall_height']),
            (self.dimensions['wall_length'] + self.dimensions['eave_extension'], self.dimensions['wall_height']),
            dxfattribs={'layer': 'EAVE'}
        )
        
    def draw_door(self, position):
        points = [
            (position, 0),
            (position, self.dimensions['door_height']),
            (position + self.dimensions['door_width'], self.dimensions['door_height']),
            (position + self.dimensions['door_width'], 0),
            (position, 0)
        ]
        self.msp.add_lwpolyline(points, dxfattribs={'layer': 'DOOR'})
        
    def draw_window(self, position):
        points = [
            (position, self.dimensions['window_sill_height']),
            (position, self.dimensions['window_sill_height'] + self.dimensions['window_height']),
            (position + self.dimensions['window_width'], self.dimensions['window_sill_height'] + self.dimensions['window_height']),
            (position + self.dimensions['window_width'], self.dimensions['window_sill_height']),
            (position, self.dimensions['window_sill_height'])
        ]
        self.msp.add_lwpolyline(points, dxfattribs={'layer': 'WINDOW'})
        
    def add_dimensions(self):
        # Add wall dimensions
        self.msp.add_linear_dimension(
            (0, -300),
            (self.dimensions['wall_length'], -300),
            (-200, -300),
            dxfattribs={'layer': 'DIMENSION'}
        ).set_text_height(100)
        
        # Add height dimension
        self.msp.add_linear_dimension(
            (-300, 0),
            (-300, self.dimensions['wall_height']),
            (-300, -200),
            dxfattribs={'layer': 'DIMENSION', 'rotation': 90}
        ).set_text_height(100)
        
    def create_elevation(self):
        # Draw all elements
        self.draw_wall()
        self.draw_eave()
        self.draw_door(self.dimensions['door1_position'])
        self.draw_door(self.dimensions['door2_position'])
        self.draw_window(self.dimensions['window1_position'])
        self.draw_window(self.dimensions['window2_position'])
        self.add_dimensions()
        
        # Save the document
        self.doc.saveas(self.filename)

if __name__ == "__main__":
    # Create and draw elevation
    drawing = ElevationDrawing("elevation2.dxf")
    drawing.create_elevation()
    print("DXF file has been created successfully with layers and dimensions!")
