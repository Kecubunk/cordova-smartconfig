Texas Instrument Chip Plugin Install Guide
================================================================================
DESCRIPTION:
1.Copy and Past the iOS folder to your project 
2.And Add it to your Xcode project by dragging and drop it 
3.Go to the Project->Build Settings->LibrarySearchPath
  add the library folder path so that project can find the library.
4 add this link in config.xml
    <feature name="ChipInterface">
        <param name="ios-package" value="ChipInterface" />
    </feature>
5. Refer wwww folder codes to integrate it cordova
