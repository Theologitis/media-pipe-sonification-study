import tkinter as tk
from tkinter import filedialog,ttk
import cv2
import pandas as pd
import mediapipe as mp
import numpy as np
import os
from scipy.interpolate import CubicSpline
import moviepy.editor as mpp
from scipy import signal
import sounddevice as sd
import soundfile as sf

mp_pose = mp.solutions.pose
mp_drawing = mp.solutions.drawing_utils
pose = mp_pose.Pose(model_complexity=1,
                    smooth_landmarks=True,
                    enable_segmentation=False,
                    smooth_segmentation=False,
                    min_detection_confidence=0.5,
                    min_tracking_confidence=0.5)

if not os.path.exists('./video'):os.makedirs('./video')
output_path='./video/Side.mp4'

def running_mean(x, N):
    cumsum = np.cumsum(np.insert(x, 0, 0)) 
    
    d=(cumsum[N:] - cumsum[:-N]) / float(N)
 
    y=np.concatenate((x[0:int(N/2)],d,x[-(int(N/2)):]),axis=None)
    return y
    
def write_landmarks_to_csv(landmarks,worldLandmarks, frame_number,data):
   
    for idx, landmark in enumerate(landmarks):
        
        data.append([frame_number, idx, mp_pose.PoseLandmark(idx).name, landmark.x, landmark.y, landmark.z,
                        worldLandmarks[idx].x,worldLandmarks[idx].y,worldLandmarks[idx].z])

def process_video():
    
    video_path = file_path_var.get()
    duration_input = duration_entry.get()
    duration = tuple(map(int, duration_input.split(',')))
    frame_number = 1
    # Open video file
    
    data = []
    normal=[]
    world=[]
    
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    cap = cv2.VideoCapture(video_path)
    fps = cap.get(cv2.CAP_PROP_FPS)
    width=int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height=int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    ratio=width/height
    out = cv2.VideoWriter(output_path, fourcc, fps, (width,height))
    total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    max_duration = total_frames / fps
    
    # Check if user input duration is higher than video's duration
    if duration[1] > max_duration:
        duration[1] = max_duration
        status_label.config(text=f"Duration exceeds video duration. Set to maximum ({max_duration} seconds)")
        root.update_idletasks()  # Update GUI
    progress_bar['maximum'] =duration[1]*fps
    
    status_label.config(text='processing video')
    while cap.isOpened() & (frame_number <= duration[1]*fps):
        ret, frame = cap.read()
        if not ret:
            break
        
        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        result = pose.process(frame_rgb)
        if (frame_number>=duration[0]*fps):
            # connections=frozenset([(1,3),(32,0)]): custom connections
            black_frame = np.zeros((height, width, 3), dtype=np.uint8)
            if (result.pose_landmarks):
                write_landmarks_to_csv(result.pose_landmarks.landmark, result.pose_world_landmarks.landmark, frame_number, data)
                # Draw the pose landmarks on the frame
                
                mp_drawing.draw_landmarks(black_frame, result.pose_landmarks, mp_pose.POSE_CONNECTIONS,
                                    mp_drawing.DrawingSpec(color=(255,255,255), thickness=2, circle_radius=2), 
                                    mp_drawing.DrawingSpec(color=(255,255,255), thickness=2, circle_radius=2)) 
            
            else:
                data.append([frame_number])
            out.write(black_frame)
        frame_number+=1
        progress_bar['value'] = frame_number
        root.update_idletasks()  # Update GUI
        
    out.release()
    data= pd.DataFrame(data,columns=['frame','keypoint','name','norm_x','norm_y','norm_z','world_x','world_y','world_z'])
    
    status_label.config(text='creating video file')
    video_clip = mpp.VideoFileClip(video_path)
    audio_clip = video_clip.audio.subclip(duration[0],duration[1])
    
    final_clip = mpp.VideoFileClip(output_path)
    final_clip = final_clip.set_audio(audio_clip)
    #final_clip.write_videofile(output_path[:-4] + "_with_audio.mp4",codec="libx264", fps=fps)
    final_clip.write_videofile(output_path[:-4] + "1.mp4",codec="libx264", fps=fps)

    # Close video clip objects
    video_clip.close()
    final_clip.close()    
  
    
    status_label.config(text='creating movement variables...')
    root.update_idletasks()
    # CALCULATING MOVEMENT VARIABLES:
    
    normal=pd.DataFrame({'x':data.norm_x,'y':data.norm_y,'z':data.norm_z,'k':data.name,'f':data.frame})
    world=pd.DataFrame({'x':data.world_x,'y':data.world_y,'z':data.world_z,'k':data.name,'f':data.frame})
  
    LAw=world.loc[(world.k=='LEFT_ANKLE'),['x','y','z']].reset_index(drop=True)
    LHw=world.loc[(world.k=='LEFT_HIP'),['x','y','z']].reset_index(drop=True)
    RAw=world.loc[(world.k=='RIGHT_ANKLE'),['x','y','z']].reset_index(drop=True)
    RHw=world.loc[(world.k=='RIGHT_ANKLE'),['x','y','z']].reset_index(drop=True)
    LSw=world[(world.k=='LEFT_SHOULDER') & (world.f>=duration[0]*fps) & (world.f<=duration[1]*fps)].reset_index(drop=True)
    RSw=world[(world.k=='RIGHT_SHOULDER') & (world.f>=duration[0]*fps) & (world.f<=duration[1]*fps)].reset_index(drop=True)
    LAw3d=np.sqrt(LAw.y**2+LAw.x**2+LAw.z**2)*100
    RAw3d=np.sqrt(RAw.y**2+RAw.x**2+RAw.z**2)*100

    LAn=normal[(normal.k=='LEFT_ANKLE') & (normal.f>=duration[0]*fps) & (normal.f<=duration[1]*fps)].reset_index(drop=True)
    LHn=normal.loc[(normal.k=='LEFT_HIP'),['x','y','z']].reset_index(drop=True)
    RAn=normal[(normal.k=='RIGHT_ANKLE')& (normal.f>=duration[0]*fps) & (normal.f<=duration[1]*fps)].reset_index(drop=True)
    RHn=normal[(normal.k=='RIGHT_HIP')& (normal.f>=duration[0]*fps) & (normal.f<=duration[1]*fps)].reset_index(drop=True)  
    LSn=normal[(normal.k=='LEFT_SHOULDER') & (normal.f>=duration[0]*fps) & (normal.f<=duration[1]*fps)].reset_index(drop=True)
    RSn=normal[(normal.k=='RIGHT_SHOULDER') & (normal.f>=duration[0]*fps) & (normal.f<=duration[1]*fps)].reset_index(drop=True)
   
    
    ## Fill NAN with average of neighbor data ##
    
    LHn = LHn.bfill().ffill()
    RHn = RHn.bfill().ffill()
    LSn=LSn.bfill().ffill()
    RSn=RSn.bfill().ffill()
    RAn=RAn.bfill().ffill()
    LAn=LAn.bfill().ffill()
   
    LHw = LHw.bfill().ffill()
    RHw = RHw.bfill().ffill()
    LSw=LSw.bfill().ffill()
    RSw=RSw.bfill().ffill()
    RAw=RAw.bfill().ffill()
    LAw=LAw.bfill().ffill()
   
    sos = signal.butter(2, 2, 'lp', fs=int(fps), output='sos')
    
    Hips_Y=1-(LHn.y.values + RHn.y.values)/2
    Hips_Y_filt=signal.sosfiltfilt(sos, Hips_Y, axis=-1, padtype='odd', padlen=None)

    
    

    Hips_X=(RHn.x.values+LHn.x.values)/2
    Hips_X_filt=signal.sosfiltfilt(sos,Hips_X,axis=-1,padtype='odd',padlen=None)

    
    Hips_Yvel = signal.savgol_filter(Hips_Y,9,2,deriv=1, delta=1/fps)
    Hips_Xvel=signal.savgol_filter(Hips_X_filt,9,2,deriv=1, delta=1/fps)
    velocity = np.column_stack((Hips_Yvel, Hips_Xvel))
    Hips_speed= np.linalg.norm(velocity,axis=1)
    
    Shoulders_Y=signal.sosfiltfilt(sos, 1-(LSn.y.values + RSn.y.values)/2, axis=-1, padtype='odd', padlen=None)
    Shoulders_Yvel=signal.savgol_filter(Shoulders_Y,9,2,deriv=1, delta=1/fps)
    Shoulders_X=(RSn.x.values+LSn.x.values)/2
    Shoulders_Xvel=signal.savgol_filter(Shoulders_X,9,2,deriv=1, delta=1/fps)
    velocity = np.column_stack((Shoulders_Yvel, Shoulders_Xvel))
    Shoulders_speed= np.linalg.norm(velocity,axis=1)
 
 
    RightFoot_Y=signal.sosfiltfilt(sos,RAn.y, axis=-1, padtype='odd', padlen=None)
    RightFoot_Yvel=signal.savgol_filter(RightFoot_Y,9,2,deriv=1, delta=1/fps)
    RightFoot_X=signal.sosfiltfilt(sos,RAn.x*ratio, axis=-1, padtype='odd', padlen=None)
    RightFoot_Xvel=signal.savgol_filter(RightFoot_X,9,2,deriv=1, delta=1/fps)
    velocity = np.column_stack((RightFoot_Yvel, RightFoot_Xvel))
    RightFoot_speed= np.linalg.norm(velocity,axis=1)
    
    LeftFoot_Y=signal.sosfiltfilt(sos,LAn.y, axis=-1, padtype='odd', padlen=None)
    LeftFoot_Yvel=signal.savgol_filter(LeftFoot_Y,9,2,deriv=1, delta=1/fps)
    LeftFoot_X=signal.sosfiltfilt(sos,LAn.x*ratio, axis=-1, padtype='odd', padlen=None)
    LeftFoot_Xvel=signal.savgol_filter(LeftFoot_X,9,2,deriv=1, delta=1/fps)
    velocity = np.column_stack((LeftFoot_Yvel, LeftFoot_Xvel))
    LeftFoot_speed= np.linalg.norm(velocity,axis=1)
    
    LeftHip_Y=signal.savgol_filter(LHn.y,9,2)
    LeftHip_Yvel=signal.savgol_filter(LeftHip_Y,9,2,deriv=1, delta=1/fps)
    
    RightHip_Y=signal.savgol_filter(RHn.y,9,2)
    RightHip_Yvel=signal.savgol_filter(RightHip_Y,9,2,deriv=1, delta=1/fps)

    
    LeftShoulder_Y=signal.savgol_filter(RSn.y,9,2)
    LeftShoulder_Yvel=signal.savgol_filter(LeftShoulder_Y,9,2,deriv=1, delta=1/fps)

    RightShoulder_Y=signal.savgol_filter(RSn.y,9,2)
    RightShoulder_Yvel=signal.savgol_filter(RightShoulder_Y,9,2,deriv=1, delta=1/fps)  
    
    LeftFootworld_Y=signal.sosfiltfilt(sos, LAw.y, axis=-1, padtype='odd', padlen=None)
    LeftFootworld_Yvel=signal.savgol_filter(LeftFootworld_Y,9,2,deriv=1, delta=1/fps)
    LeftFootworld_X=signal.savgol_filter(LAw.x,9,2)
    LeftFootworld_Xvel=signal.savgol_filter(LeftFootworld_X,9,2,deriv=1, delta=1/fps)
    velocity = np.column_stack((LeftFootworld_Yvel, LeftFootworld_Xvel))
    LeftFootworld_speed= np.linalg.norm(velocity,axis=1)
    
    RightFootworld_Y=signal.sosfiltfilt(sos, RAw.y, axis=-1, padtype='odd', padlen=None)
    RightFootworld_Yvel=signal.savgol_filter(RightFootworld_Y,9,2,deriv=1, delta=1/fps)
    RightFootworld_X=signal.sosfiltfilt(sos, RAw.y, axis=-1, padtype='odd', padlen=None)
    RightFootworld_Xvel=signal.savgol_filter(RightFootworld_X,9,2,deriv=1, delta=1/fps)
    velocity = np.column_stack((RightFootworld_Yvel, RightFootworld_Xvel))
    RightFootworld_speed= np.linalg.norm(velocity,axis=1)
    
    #upsampling

    status_label.config(text='saving data...')
    sonifyData= pd.DataFrame({
    'Hips_Y': Hips_Y_filt,
    'Hips_Yvel': Hips_Yvel,
    'Hips_speed': Hips_speed,
    'Shoulders_Y': Shoulders_Y,
    'Shoulders_Yvel': Shoulders_Yvel,
    'Shoulders_speed': Shoulders_speed,
    'RightFoot_Y': RightFoot_Y,
    'RightFoot_Yvel': RightFoot_Yvel,
    'RightFoot_speed': RightFoot_speed,
    'LeftFoot_Y': LeftFoot_Y,
    'LeftFoot_Yvel': LeftFoot_Yvel,
    'LeftFoot_speed': LeftFoot_speed,
    'LeftHip_Y':LeftHip_Y,
    'LeftHip_Yvel':LeftHip_Yvel,
    'RightHip_Y':RightHip_Y,
    'LeftHip_Yvel':LeftHip_Yvel,
    'LeftShoulder_Y':LeftShoulder_Y,
    'LeftShoulder_Yvel':LeftShoulder_Yvel,
    'RightShoulder_Y':RightShoulder_Y,
    'RightShoulder_Yvel':RightShoulder_Yvel,
    'LeftFootworld_Y':LeftFootworld_Y,
    'LeftFootworld_Yvel':LeftFootworld_Yvel,
    'LeftFootworld_speed':LeftFootworld_speed,
    'RightFootworld_Y':RightFootworld_Y,
    'RightFootworld_Yvel':RightFootworld_Yvel,
    'RightFootworld_speed':RightFootworld_speed
     })
    
    csv_data=sonifyData.transpose()
    csv_data.to_csv('./data.csv')
    cap.release()
    status_label.config(text='data created successfully')
    
    # Close the video file
  
def get_stereo_mix_device():
    possible_names = [
        "Stereo Mix",
        "What U Hear",
        "Wave Out Mix",
        "Rec. Playback",
        "Wave",
        "Stereo Out",
        #"Primary Sound Capture Driver"
    ]
    devices = sd.query_devices()
    for i, device in enumerate(devices):
        if any(name in device['name'] for name in possible_names):
            print(device['name'])
            return i
    raise ValueError("No suitable recording device found. Please ensure 'Stereo Mix' or equivalent is enabled.")
   
def record_audio():
    global recording_active, audio_frames
    if not recording_active:
        print('Recording audio...')
        global audio_output_path
        audio_output_path = file_path_var.get()[:-4] + "_audio.wav"
        recording_active = True
        audio_frames = []
        record_button.config(text="Stop Recording")
        device_info = sd.query_devices()
        print("Available devices:", device_info)

        # Replace with the correct device index for your soundcard
        soundcard_device_index = get_stereo_mix_device()
        sd.default.samplerate = 48000
        sd.default.channels = 2
        sd.default.clip_off=True
        sd.default.dtype = 'float32'
        sd.default.blocksize=18432
        sd.default.device = soundcard_device_index
        sd.default.latency=3
        sd.default.dither_off=False
        stream = sd.InputStream(callback=audio_callback)
        stream.start()
        
    else:
        print('Stopping recording...')
        recording_active = False
        record_button.config(text="Record")
        audio_output_path = filedialog.asksaveasfilename(defaultextension=".wav", filetypes=[("WAV files", "*.wav")])
        sf.write(audio_output_path, np.vstack(audio_frames),48000, format='WAV', subtype='FLOAT')
        print(f'Audio recorded and saved at: {audio_output_path}')


def audio_callback(indata, frames, time, status):
    global audio_frames
    audio_frames.append(indata.copy())
 

def open_file_dialog():
    file_path = filedialog.askopenfilename(filetypes=[("Video files","*.mp4 *.avi")])
    file_path_var.set(file_path)


# Create the main window
# Create the main window
root = tk.Tk()
root.title("Mediapipe Pose Landmarker video processor")

# Create and position widgets
file_path_var = tk.StringVar()

label = tk.Label(root, text="Select a video file:")
label.pack(pady=10)

button = tk.Button(root, text="Browse", command=open_file_dialog)
button.pack(pady=5)

file_path_entry = tk.Entry(root, textvariable=file_path_var)
file_path_entry.pack(pady=5)

duration_label = tk.Label(root, text="Enter duration as: start , end in seconds (e.g. 10,20 )")
duration_label.pack(pady=5)

duration_entry = tk.Entry(root)
duration_entry.pack(pady=5)

start_button = tk.Button(root, text="Start", command=process_video)
start_button.pack(pady=5)

recording_active = False
record_button = tk.Button(root, text="Record", command=record_audio)
record_button.pack(pady=5)

status_label = tk.Label(root, text="")
status_label.pack(pady=5)

progress_bar = ttk.Progressbar(root, orient='horizontal', length=300, mode='determinate')
progress_bar.pack(pady=10)

status_label = tk.Label(root, text="")
status_label.pack(pady=10)
# Run the application
root.mainloop()