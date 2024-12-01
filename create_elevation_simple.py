import ezdxf

def create_simple_elevation(filename="elevation_simple.dxf"):
    # Create a new DXF document
    doc = ezdxf.new("R2010")
    msp = doc.modelspace()
    
    # Define dimensions (in mm)
    wall_length = 9000
    wall_height = 3000
    
    # Door dimensions
    door_width = 900
    door_height = 2100
    door1_position = 600
    door2_position = 6500
    
    # Window dimensions
    window_width = 1200
    window_height = 1200
    window_sill_height = 900
    window1_position = 2500
    window2_position = 4500
    
    # Create a single polyline for the entire outline
    points = []
    
    # Start with main wall outline
    points.extend([
        (0, 0),                    # Start at bottom-left
        (door1_position, 0),       # To first door
        (door1_position, door_height),
        (door1_position + door_width, door_height),
        (door1_position + door_width, 0),
        (window1_position, 0),     # To first window
        (window1_position, window_sill_height),
        (window1_position, window_sill_height + window_height),
        (window1_position + window_width, window_sill_height + window_height),
        (window1_position + window_width, window_sill_height),
        (window2_position, window_sill_height),
        (window2_position, window_sill_height + window_height),
        (window2_position + window_width, window_sill_height + window_height),
        (window2_position + window_width, window_sill_height),
        (door2_position, window_sill_height),
        (door2_position, 0),       # To second door
        (door2_position, door_height),
        (door2_position + door_width, door_height),
        (door2_position + door_width, 0),
        (wall_length, 0),          # To wall end
        (wall_length, wall_height),
        (0, wall_height),          # Back to start
        (0, 0)
    ])
    
    # Add the polyline to the modelspace
    msp.add_lwpolyline(points)
    
    # Save the document
    doc.saveas(filename)
    print(f"Created {filename} successfully!")

if __name__ == "__main__":
    create_simple_elevation()
