



```
# search
    -> search by tags
    -> support & | ! [] ()
    -> reserved !@#$%^&*[]{}(),/\``~ aka [a-Z09_-]
    -> special tags (private, session_seen, gps, video_[type], img_[type], exported, missing, all)
    -> search by name, by range date
        -> name #[n:name] or #[n_end: name] or #[n_start: name] or #[meddle: name]
        -> data #[d:y-m-d-H-M-S:y-m-d-H-M-S] if component is defined what come after it is optional
    -> support auto complete
    => example
        #a & (#b & #c | #d) & #e
        -> #a#e#d, #a#e#b#c

# search result
    -> scrolling list contains items that will display an &tags (#tag1#tag2)
    -> if no item selected => display all
    -> you can select multiple item that will be displayed

# search history
    -> can make a search history as favorite
    -> sorted by time

# export
    -> folders name export_id has max size of 4.6GB
    -> private media of a user compressed in encrypted zip file
    -> config file for the data base

# user
    -> save favorite search
    -> save search history
    -> save seen media and videos per session
    -> can create new session
    -> can add private media
    -> can change visibility of his own media

# sort
    -> by name, type, match tags, data, size
    -> can provide priority between sort types

# tag
    -> users can remove, add, edit tags of an media

# data_base
    -> tags (+id, U(name), color, created_by, created_date, update_date, updated_by)
    -> users (+user_id, nickname, password, create_date, last_login)
    -> search (+id, content, user_id, created_date, isFavorite, update_date)
    -> sessions (+id, name, date, update_date)
    -> media (+name, type, date, size, ...meta_data, hasGps, add_by)
    -> sessions_media(+session_id, +media_id)
    -> private (+user, +media, date)
    -> tag_list (+media, +tag_id)
    -> search_check (+id, search_id, list)


# front end
    - login page
    - type of display (list, gallery, icons)
    - zoom in out , translate in video and image
    - video preview
    - video skip
    - navigate
    - button to add media
    - responsive (phone)
    - home page
        - three section

# info 

	- global setting to save sorting preferences
		- of history
		- collapse componenet
	- sort support priotity, mouvable, des asec

# feature
	- ai detect person and find other images that contain that person
		
```




```
EXIF stands for "Exchangeable Image File Format." It is a standard file format used to store metadata, such as information about the camera settings, date and time the image was captured, GPS coordinates, and other relevant information, within digital image files. This metadata is automatically recorded by digital cameras and some other imaging devices when an image is taken.

The EXIF data is embedded directly into the image file, typically in the form of a header, and it remains there even if the image is transferred or copied to another device or platform. This makes it a useful way to preserve important information about the image and its capture details.

Some of the common EXIF metadata that can be found in image files include:

1. Camera Information: Make, model, and serial number of the camera used to take the photo.
    
2. Date and Time: The date and time the image was captured.
    
3. Exposure Settings: Information about the camera's aperture, shutter speed, ISO sensitivity, exposure compensation, and exposure mode.
    
4. Image Dimensions: The size of the image in pixels.
    
5. GPS Data: GPS coordinates (latitude, longitude, and altitude) where the photo was taken, if available.
    
6. Software Details: Information about the software used to process the image.
    
7. Orientation: The orientation of the camera when the photo was taken (e.g., portrait or landscape).
    
8. White Balance: The white balance setting used to capture the image.
    
9. Flash Information: Whether the flash was fired or not.
    

EXIF data can be accessed and viewed using various image editing software and image viewers. Some websites and applications also allow users to view and edit EXIF data for their images. However, it's essential to be mindful of privacy and security concerns when sharing images with EXIF data containing sensitive information, such as GPS coordinates that reveal the location of the photo's origin.
```


```
While EXIF (Exchangeable Image File Format) is primarily associated with image files, it is not commonly used for video files. Instead, video files often utilize other metadata formats to store relevant information about the video.

For videos, the most common metadata format is called "XMP" (Extensible Metadata Platform), which was developed by Adobe. XMP allows for the embedding of metadata into video files, including information about the video's creation, camera settings, and other details.

Another format used for video metadata is "ID3" tags, which are commonly used for storing metadata in audio files but can also be used for video files in some cases.

It's worth noting that the specific metadata formats and the information they can store may vary depending on the video file type and the device or software used to capture and process the video. Some professional video formats, like MXF (Material Exchange Format), may have more extensive metadata capabilities compared to consumer formats like MP4.

If you need to access or edit video metadata, you can use various video editing software or metadata management tools that support the specific format used by your video files.
```