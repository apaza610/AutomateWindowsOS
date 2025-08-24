import os
from PIL import Image

def convert_and_resize_image():
    # Ask the user for the image file path
    file_path = input("Please enter the full path to the image file: ").strip()
    file_path = file_path.replace('"', '')

    kanji = input("representa el kanji: ").strip()
    
    # Check if the file exists
    if not os.path.isfile(file_path):
        print("Error: File not found. Please check the path and try again.")
        return

    # Define the output directory and filename
    output_dir = r"E:\misapps\web\HanziKanji\media"
    output_path = os.path.join(output_dir, f"{kanji}.jpg")
    
    # Create the output directory if it doesn't exist
    if not os.path.exists(output_dir):
        try:
            os.makedirs(output_dir)
            print(f"Created directory: {output_dir}")
        except Exception as e:
            print(f"Error creating directory {output_dir}: {e}")
            return
    
    try:
        # Open the image
        with Image.open(file_path) as img:
            # Convert to RGB if necessary (e.g., for PNG with transparency)
            if img.mode in ('RGBA', 'LA', 'P'):
                img = img.convert('RGB')
            
            # Resize the image to 512x512 pixels
            img_resized = img.resize((512, 512), Image.Resampling.LANCZOS)
            
            # Save as JPEG
            img_resized.save(output_path, 'JPEG', quality=95)
        
        print(f"Image successfully converted, resized, and saved as: {output_path}")
        
    except Exception as e:
        print(f"An error occurred while processing the image: {e}")

if __name__ == "__main__":
    convert_and_resize_image()