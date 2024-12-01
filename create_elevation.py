import ezdxf

def create_elevation(filename="elevation.dxf"):
    # Create a new DXF document
    doc = ezdxf.new("R2010")  # AutoCAD 2010 format
    
    # Get the model space
    msp = doc.modelspace()
    
    # Define dimensions (in mm)
    wall_length = 9000
    wall_height = 3000
    eave_extension = 600
    
    door_width = 900
    door_height = 2100
    door1_position = 600
    door2_position = 6500
    
    window_width = 1200
    window_height = 1200
    window_sill_height = 900
    window1_position = 2500
    window2_position = 4500
    
    # Draw main outline
    points = [
        (0, 0),
        (wall_length, 0),
        (wall_length, wall_height),
        (0, wall_height),
        (0, 0)
    ]
    msp.add_lwpolyline(points)
    
    # Draw eave
    msp.add_line((-eave_extension, wall_height), (wall_length + eave_extension, wall_height))
    
    # Draw first door
    door1_points = [
        (door1_position, 0),
        (door1_position, door_height),
        (door1_position + door_width, door_height),
        (door1_position + door_width, 0),
        (door1_position, 0)
    ]
    msp.add_lwpolyline(door1_points)
    
    # Draw second door
    door2_points = [
        (door2_position, 0),
        (door2_position, door_height),
        (door2_position + door_width, door_height),
        (door2_position + door_width, 0),
        (door2_position, 0)
    ]
    msp.add_lwpolyline(door2_points)
    
    # Draw first window
    window1_points = [
        (window1_position, window_sill_height),
        (window1_position, window_sill_height + window_height),
        (window1_position + window_width, window_sill_height + window_height),
        (window1_position + window_width, window_sill_height),
        (window1_position, window_sill_height)
    ]
    msp.add_lwpolyline(window1_points)
    
    # Draw second window
    window2_points = [
        (window2_position, window_sill_height),
        (window2_position, window_sill_height + window_height),
        (window2_position + window_width, window_sill_height + window_height),
        (window2_position + window_width, window_sill_height),
        (window2_position, window_sill_height)
    ]
    msp.add_lwpolyline(window2_points)
    
    # Save the document
    doc.saveas(filename)

if __name__ == "__main__":
    create_elevation()
    print("DXF file has been created successfully!")
