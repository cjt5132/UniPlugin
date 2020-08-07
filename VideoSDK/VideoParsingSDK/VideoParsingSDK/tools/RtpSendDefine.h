#ifndef RTPSENDDEFINE_H_
#define RTPSENDDEFINE_H_


//typedef unsigned long 	UInt32;
typedef unsigned int       DWORD;

#define RTPSENDWAITACTIVETIME 25	// √ª”– ’µΩ–ƒÃ¯≥¨ ± ±º‰
#define RTPSENDSENDACTIVETIME 20	// –ƒÃ¯∑¢ÀÕ ±º‰

#define     VIDEOMAXSIZE    500*1024

#define  	YRVIDEO			'MVDA'
#define		CMDSESSION		'SCOM'
#define     SZYAUDIO_EX		'MAER'
#define 	DATA_TOKEN		"<!ROW>"

enum	 TCMDTYPE
{
    INVALID_MSG	= -1,
    MSG_CAPLOGIN = 0x70+0,						//øÕªß∂Àµ«¬Ω
    MSG_VIEWLOGIN=0x70+1,						//π€ø¥∂Àµ«¬Ω
    MSG_LOGINRET,							//∑˛ŒÒ∆˜∑µªÿ
    MSG_SENDSWITCH,							//øÕªß∂À”Î∑˛ŒÒ∆˜∑¢ÀÕø™πÿ
    MSG_KEEPALIVE,							//–ƒÃ¯±£ªÓºÏ≤‚
    MSG_PTZCOMMAND,							//‘∆Ã®øÿ÷∆
    MSG_SENDLOGFILE,						//∑¢ÀÕ»’÷æŒƒº˛
    MSG_PARAMCONFIG,						//≤Œ ˝≈‰÷√
    MSG_GETPARAMCONFIG =0x70+8,					//ªÒ»°≤Œ ˝
    MSG_AUDIODATA,							//“Ù∆µ ˝æ›
    MSG_AUDIODREQ,							//“Ù∆µ«Î«Û
    MSG_PLAYBACKREQ,						//¬ºœÒªÿ∑≈«Î«Û
    MSG_PLAYBACKASK,						//¬ºœÒªÿ∑≈”¶¥
    MSG_PLAYBACKCTL,						//¬ºœÒªÿ∑≈øÿ÷∆
    MSG_AUDIODATAGSM,						//“Ù∆µ ˝æ›GSM
    MSG_AUDIOREJECT,						//“Ù∆µ«Î«Ûæ‹æ¯
    MSG_MIRRORINC,							//æµœÒ¡¨Ω”++
    MSG_MIRRORDEC,							//æµœÒ¡¨Ω”--
    MSG_MIRRORREQ,							//æµœÒ∑˛ŒÒ∆˜µ«¬º«Î«Û ”∆µ
    MSG_ViewOutTalk = 26,					//‰Ø¿¿∂ÀÕÀ≥ˆΩ≤ª∞◊¥Ã¨
    MSG_ViewTalk = 32,						//Õ®÷™≤…ºØ∂À£¨‰Ø¿¿∂À’˝‘⁄Ω≤ª∞
    MSG_UPLOADCAPSTATUE = 35,               //≤…ºØ∂À“Ï≥£◊¥Ã¨…œ¥´£®35£©
    MSG_CMDMAX,
};

enum	 TMSGRETTYPE						//∑µªÿƒ⁄»›
{
    INVALID_RETMSG	= -1,
    MSG_CAPLOGINSUCCESS = 0,			//øÕªß∂Àµ«¬Ω≥…π¶
    MSG_VIEWLOGINSUCCESS = 1,			//π€ø¥∂Àµ«¬Ω≥…π¶
    MSG_CAPLOGINPSWRONG ,				//øÕªß∂Àµ«¬Ω√‹¬Î¥ÌŒÛ
    MSG_CAPLOGINHASONE ,				//øÕªß∂Àµ«¬Ω“—æ≠”–¡¨Ω”
    MSG_VIEWLOGINPSWRONG,				//π€ø¥∂Àµ«¬Ω ß∞‹
    MSG_VIEWLOGINOVER ,					//π€ø¥∂À≥¨π˝»À ˝
    MSG_AUDIOCONNECTED ,				//“Ù∆µΩ”»Î
    MSG_AUDIOREFUSED ,					//“Ù∆µæ‹æ¯
    MSG_AUDIOQUIT ,						//“Ù∆µÕÀ≥ˆ
    MSG_AUDIOKICK,						//“Ù∆µÃﬂ≥ˆ
    MSG_RETMAX,
    
};

typedef enum
{
    AVIOCTRL_PTZ_STOP					= 0,
    AVIOCTRL_PTZ_UP						= 1,
    AVIOCTRL_PTZ_DOWN					= 2,
    AVIOCTRL_PTZ_LEFT					= 3,
    AVIOCTRL_PTZ_LEFT_UP				= 4,
    AVIOCTRL_PTZ_LEFT_DOWN				= 5,
    AVIOCTRL_PTZ_RIGHT					= 6,
    AVIOCTRL_PTZ_RIGHT_UP				= 7,
    AVIOCTRL_PTZ_RIGHT_DOWN				= 8,
    AVIOCTRL_PTZ_AUTO					= 9,
    AVIOCTRL_PTZ_SET_POINT				= 10,
    AVIOCTRL_PTZ_CLEAR_POINT			= 11,
    AVIOCTRL_PTZ_GOTO_POINT				= 12,
    
    AVIOCTRL_PTZ_SET_MODE_START			= 13,
    AVIOCTRL_PTZ_SET_MODE_STOP			= 14,
    AVIOCTRL_PTZ_MODE_RUN				= 15,
    
    AVIOCTRL_PTZ_MENU_OPEN				= 16,
    AVIOCTRL_PTZ_MENU_EXIT				= 17,
    AVIOCTRL_PTZ_MENU_ENTER				= 18,
    
    AVIOCTRL_PTZ_FLIP					= 19,
    AVIOCTRL_PTZ_START					= 20,
    
    AVIOCTRL_LENS_APERTURE_OPEN			= 21,
    AVIOCTRL_LENS_APERTURE_CLOSE		= 22,
    
    AVIOCTRL_LENS_ZOOM_IN				= 23,
    AVIOCTRL_LENS_ZOOM_OUT				= 24,
    
    AVIOCTRL_LENS_FOCAL_NEAR			= 25,
    AVIOCTRL_LENS_FOCAL_FAR				= 26,
    
    AVIOCTRL_AUTO_PAN_SPEED				= 27,
    AVIOCTRL_AUTO_PAN_LIMIT				= 28,
    AVIOCTRL_AUTO_PAN_START				= 29,
    
    AVIOCTRL_PATTERN_START				= 30,
    AVIOCTRL_PATTERN_STOP				= 31,
    AVIOCTRL_PATTERN_RUN				= 32,
    
    AVIOCTRL_SET_AUX					= 33,
    AVIOCTRL_CLEAR_AUX					= 34,
    AVIOCTRL_MOTOR_RESET_POSITION		= 35,
}ENUM_PTZCMD;

//∑¢ÀÕ ”∆µ∫Ø ˝∫Õœ‡πÿΩ·ππÃÂ
struct VIDEO_HEADER
{
    int 			nChannel;             	//Õ®µ¿∫≈,¥”0ø™ ºº∆ ˝
    unsigned long	ts;						// ±º‰¥¡£¨µ•Œª£∫∫¡√Î£¨µ›‘ˆ
    int 			w;						// ”∆µøÌ
    int 			h;						// ”∆µ∏ﬂ
    int 			fr;						//÷°¬
    int 			bKey;					// «∑Òπÿº¸÷°
    int 			len;					// ˝æ›≥§∂»
};

//“Ù∆µ ˝æ›∞¸Õ∑
typedef struct AUD_HDR_T_
{
    //4◊÷Ω⁄
    int	nSamplePerSec:16;        //≤…—˘¬
    int	wBitPerSample:8;         //Œª ˝
    int nChannel:4;              //Õ®µ¿ ˝
    int	wFormat:4;               //—πÀı∏Ò Ω
}AUD_HDR_T;

//◊™∑¢∑¢ÀÕ∏¯IPCµƒ“Ù∆µ ˝æ›Õ∑
typedef struct
{
    int session;
    unsigned int ts;
    AUD_HDR_T header;
    int datalen;
    int dataType:1;		//Œ™0
    int reserves:31;	//±£¡Ù◊÷∂Œ
}AUD_HDR_NEW;


//28∏ˆ◊÷Ω⁄
typedef struct RTP_HDR_T_{
    //16∏ˆ◊÷Ω⁄
    
    uint	session;		// ˝æ›¿‡–Õ
    DWORD	ts;			    /*timestamp*/
    DWORD	dataLen;		// ˝æ›≥§∂»
    
    DWORD	w:16;			//øÌ∂»
    DWORD	h:16;			//∏ﬂ∂»
    //4◊÷Ω⁄
    DWORD	nframeCount:16;	//÷°∫≈
    DWORD	NowDownRate:16;	//µ±«∞ π”√µƒœ¬‘ÿ¡˜¡øK
    //4◊÷Ω⁄
    DWORD	keyCount:16;	//πÿº¸÷°º∆ ˝
    DWORD    k:1;           /*keyframe or not,0,no,1,yes*/
    DWORD	NowUpRate:15;	//µ±«∞ π”√µƒ…œ¥´¡˜¡øK
    			
    //4◊÷Ω⁄
    DWORD	cpuUse:7;		//cpu π”√¬
    DWORD	vs:4;			/*video size*/
    DWORD	fr:5;			/*frame rate*/
    UInt32	bFilpH:1;		/*…œœ¬∑≠◊™¥¶¿Ì*/
    UInt32	bFlipUV:1;		//UV∑≠◊™¥¶¿Ì
    
    DWORD 	rotateFlag:2;   //À≥ ±’Î–˝◊™±Íº« 0:0°„,1:180°„,2:90°„,3:270°„
    DWORD	bNewSizeFlag:1;			// «∑Ò√˜»∑÷ß≥÷∂¡»°øÌ∏˙∏ﬂ µƒ–≠“È∞¸Õ∑,1:÷ß≥÷∂¡»°øÌ∏˙∏„£¨0Œ™≤ª÷ß≥÷
    DWORD	reserves:11;		//±£¡Ù
}RTP_HDR_T;

// ∂®“Âœ˚œ¢µƒΩ·ππÃÂ
#pragma pack(1)										//  πΩ·ππÃÂµƒ ˝æ›∞¥’’1◊÷Ω⁄¿¥∂‘∆Î, °ø’º‰
struct TMSG_HEADER
{
    uint 	session;					//–≠“È±Í ∂£¨‘⁄¥ÀŒ™°ØTCMD°Ø
    char    cMsgID;						// œ˚œ¢±Í ∂
};

//’À∫≈√‹¬Îµ«¬Ω»œ÷§
//øÕªß∂Àµ«¬Ω
struct TMSG_CAPLOGIN
{
    struct TMSG_HEADER header;
    char password[20];
    char SxtID[30];
};

//øÕªß∂À”Î∑˛ŒÒ∆˜ø™πÿ∑¢ÀÕ ˝æ›
//ø™πÿ ˝æ›∑¢ÀÕ
struct TMSG_SENDSWITCH
{
    struct TMSG_HEADER header;
    BOOL		m_nSwitch;	
};

struct TMSG_PTZCOMMAND
{
    struct TMSG_HEADER header;
    char	m_nFunc;				//功能
    char	m_nCtl;					//动作
    char	m_nSpeed;               //转速
};


//–ƒÃ¯±£ªÓºÏ≤‚
struct TMSG_KEEPALIVE
{
    struct TMSG_HEADER header;
    char endChar;// xml¿‡–Õ
};

//∑˛ŒÒ∆˜∑µªÿ
struct TMSG_LOGINRET
{
    struct TMSG_HEADER header;
    int		m_nStatus;
};

struct TMSG_GET_VOLUME
{
    struct TMSG_HEADER header;
    int		m_nStatus;
    int     volume;
};

struct TMSG_AUDIODREQ
{
    struct TMSG_HEADER header;
    int		bJoin;
};

struct TMSG_AUDIOSTOP
{
    struct TMSG_HEADER header;
    int		bJoin;
};

struct TMSG_STARTRECORD
{
    struct TMSG_HEADER header;
    int		startRecord;
};

struct TMSG_SETPARAMCONFIG
{
    struct TMSG_HEADER header;
    int		videoParam;
};

struct TMSG_VOLUME
{
    struct TMSG_HEADER header;
    int		volume;
};




#pragma pack() //±£¥Ê∂‘∆Î◊¥Ã¨

#endif
