# media-pipe-sonification-study
A prototype application using media pipe for sonification and related material

video_convert is an application developed to facilitate the integration of MoCap data in sonifyFOLK platform https://github.com/omisgeld/SonifyFOLKSMC2023

INSTRUCTIONS:
1. download the video_converter.exe file and the source folder of sonifyFOLK
2. place the .exe file inside tthe source folder
3. Run the .exe file and open a video file (*avi,*mp4)
4. select desired clip typing (start,end) in seconds. eg(60,90) selects clip from 1:00 to 1:30
5. click "start"
6. Once the "data created successfuly" appears the data are loaded and you are ready to run the sonifyFOLK platform. You can do that by running index.html in a local server.
7. If you wish to save your sound design you can use the "record" button.

For media pipe to work better, ensure that there is a uniformal background ( one color , no movement happening in the bacgkround, no changing in intensities e.g. lighting ) and adequate contrast between the outfit of the person being tracked and the bagkround.
Also, make sure only one person is in the frame in the clip you select. For best performance the person should be at distance 2-5m to the camera and facing front. Changes in orientation or distance might cause some glitches and overall decrease in the quality.
