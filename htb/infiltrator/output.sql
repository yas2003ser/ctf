PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE [om_user_master] (
                  [user_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                  [server_user_id] INTEGER,
                  [user_key] NVARCHAR(20),
                  [updated_date] DATETIME,
                  [display_name] NVARCHAR(50),
                  [gender] CHAR(1),
                  [group_name] NVARCHAR(50),
                  [new_group_name] NVARCHAR(100),
                  [email] NVARCHAR(100),
                  [phone] NVARCHAR(20),
                  [personal_message] NVARCHAR(150),
                  [status] NVARCHAR(50),
                  [is_active] BOOLEAN,
                  [chatformat] NVARCHAR(100),
                  [api_personal_message] NVARCHAR(150),
                  [rank] INTEGER
                  );
INSERT INTO om_user_master VALUES(1,5,'5@a','2024-02-25 16:20:02.8079958','O.martinez','','Others','Others','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(2,1,'1@a','2024-02-25 16:20:02.8381333','Admin','','Administration','Administration','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(3,2,'2@a','2024-02-25 16:20:02.8381333','D.anderson','','Marketing Team','Marketing Team','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(4,3,'3@ ','2024-02-25 16:20:02.8381333','L.clark','','Marketing Team','Marketing Team','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(5,4,'4@a','2024-02-25 16:20:02.8381333','M.harris','','Developers','Developers','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(6,6,'6@a','2024-02-25 16:20:02.8381333','A.walker','','Others','Others','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(7,7,'7@a','2024-02-25 16:20:02.8381333','K.turner','','QA Testers','QA Testers','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(8,8,'8@ ','2024-02-25 16:20:02.8381333','E.rodriguez','','Digital Influencer Marketing','Digital Influencer Marketing','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(9,9,'9@a','2024-02-25 16:20:02.8381333','winrm_svc','','Management and Security','Management and Security','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(10,10,'10@a','2024-02-25 16:20:02.8381333','Developer_01','','Developers','Developers','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(11,11,'11@a','2024-02-25 16:20:02.8381333','Developer_02','','Developers','Developers','','','','F',1,'',NULL,NULL);
INSERT INTO om_user_master VALUES(12,12,'12@a','2024-02-25 16:20:02.8381333','Developer_03','','Developers','Developers','','','','F',1,'',NULL,NULL);
CREATE TABLE [om_user_photo] (
                  [photo_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                  [user_id] INTEGER CONSTRAINT [UserPhoto_foreignkey] REFERENCES [om_user_master]([user_id]) ON DELETE CASCADE ON UPDATE NO ACTION,
                  [server_user_id] INTEGER,
                  [photo_key] NVARCHAR(100),
                  [photo_format] NVARCHAR(20)
                  );
INSERT INTO om_user_photo VALUES(1,3,2,'U20219021945','Jpeg');
INSERT INTO om_user_photo VALUES(2,4,3,'U30219021701','Jpeg');
INSERT INTO om_user_photo VALUES(3,5,4,'U40219021603','Jpeg');
INSERT INTO om_user_photo VALUES(4,6,6,'U60219021831','Jpeg');
INSERT INTO om_user_photo VALUES(5,7,7,'U70219022015','Jpeg');
INSERT INTO om_user_photo VALUES(6,8,8,'U80219021917','Jpeg');
CREATE TABLE [om_notes] (
                 note_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                 title nvarchar(200) NOT NULL,
                 description NTEXT,
                 is_deleted BOOLEAN,
                 revision INTEGER,
                 lastmodifieddate DATETIME,
                 last_modifiedby INTEGER,
                 is_stickynotes BOOLEAN,
                 is_star BOOLEAN NULL,
                 is_lockedstickynotes BOOLEAN,
                 xlocation INTEGER,
                 ylocation INTEGER,
                 user_id INTEGER,
                 message_id NVARCHAR(20),
                 stickycolor NVARCHAR(30),
                 stickywidth INTEGER,
                 stickyheight INTEGER,
                 msg_format NVARCHAR(60),
                 [created_date] datetime NULL,
                 [type] nvarchar(2) NULL,
                 [arg1] nvarchar(200) NULL,
                 [arg2] nvarchar(200) NULL,
								 [server_note_id] INTEGER,
								 [module_type] nvarchar(2) NULL,
								 [module_id] INTEGER,
								 [snooze_time] datetime NULL,
                 [remote_server_id] INTEGER NULL
                 );
CREATE TABLE [om_notes_user] (
                  [note_user_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                  [note_id] Integer CONSTRAINT [om_notes_user_fk] REFERENCES [om_notes]([note_id]) ON DELETE CASCADE ON UPDATE NO ACTION,
                  [user_id] Integer,
                  [role]  nvarchar(1),
                  [is_active] BOOLEAN,
                  [is_star] BOOLEAN,
                  [user_display_name] NVARCHAR(50) NULL
                  );
CREATE TABLE [om_reminder] (
                 reminder_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                 title nvarchar(200) NOT NULL,
                 key NTEXT,
                 details NTEXT,
                 users NTEXT,
                 application NTEXT,
                 type nvarchar(200),
                 hostip NTEXT,
                 repeat nvarchar(200),
                 clear nvarchar(200),
                 rdate nvarchar(30),
                 is_sent BOOLEAN,
								 repeat_option nvarchar(50),
								 [reminder_time] datetime NULL,
								 [snooze_time] datetime NULL
                 );
CREATE TABLE [om_custom_status] (
              cusstatus_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              status nvarchar(200) NOT NULL,
              replymsg NTEXT,
              chatwindow nvarchar(30) NOT NULL
              );
CREATE TABLE [om_escape_message] (
              escapemsg_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              escapemsg NTEXT
              );
CREATE TABLE [om_hide_usergroup] (
                filter_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                user_id INTEGER,
                groupname NVARCHAR(100)
                );
CREATE TABLE [om_custom_group_new] (
          [custom_group_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          [custom_group_name] NVARCHAR(100),
          [server_custom_group_id] INTEGER,
          [is_default] BOOLEAN
          );
CREATE TABLE [om_custom_group_user_new] (
                [custom_group_user_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                [custom_group_id] INTEGER CONSTRAINT [groupusers_foreignkey] REFERENCES [om_custom_group_new]([custom_group_id]) ON DELETE CASCADE ON UPDATE NO ACTION,
                [server_user_id] INTEGER,
                [group_name] NVARCHAR(100),
                [chatroom_key] NVARCHAR(100),
                [is_active] BOOLEAN
                );
CREATE TABLE [om_chatroom] (
                  [chatroom_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                  [chatroom_name] NVARCHAR(50),
                  [chatroom_key] NVARCHAR(50),
                  [chatroom_new_name] NVARCHAR(100),
                  [photo_key] NVARCHAR(100),
                  [chatroom_new_key] NVARCHAR(100),
                  [chatroom_notification] BOOLEAN,
                  [updated_date] DATETIME,
                  [leave_room] BOOLEAN,
                  [admin_only_chat] BOOLEAN,
									[last_message_date] DATETIME,
                  [is_remote_server] BOOLEAN,
                  [remote_server_id] INTEGER,
                  [is_active] BOOLEAN,
									[last_message_id] NVARCHAR(50),
                  [pin_message] NTEXT
                  );
INSERT INTO om_chatroom VALUES(1,'General_chat','20240219160702@conference.com','General_chat','','20240219160702@conference.com',1,'2024-02-20 01:07:02.909',0,0,NULL,0,0,1,NULL,NULL);
INSERT INTO om_chatroom VALUES(2,'Chiefs_Marketing_chat','20240220014618@conference.com','Chiefs_Marketing_chat','','20240220014618@conference.com',1,'2024-02-20 10:46:18.858',0,0,NULL,0,0,1,NULL,NULL);
CREATE TABLE [om_chatroom_user] (
                [chatroom_user_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                [chatroom_id] INTEGER CONSTRAINT [chatroomusers_foreignkey] REFERENCES [om_chatroom]([chatroom_id]) ON DELETE CASCADE ON UPDATE NO ACTION,
                [server_user_id] INTEGER,
                [role] text,
                [is_active] BOOLEAN,
                [user_display_name] NVARCHAR(50)
                );
INSERT INTO om_chatroom_user VALUES(1,1,6,'M',1,'');
INSERT INTO om_chatroom_user VALUES(2,1,1,'M',1,'');
INSERT INTO om_chatroom_user VALUES(3,1,2,'M',1,'');
INSERT INTO om_chatroom_user VALUES(4,1,10,'M',1,'');
INSERT INTO om_chatroom_user VALUES(5,1,11,'M',1,'');
INSERT INTO om_chatroom_user VALUES(6,1,12,'M',1,'');
INSERT INTO om_chatroom_user VALUES(7,1,8,'M',1,'');
INSERT INTO om_chatroom_user VALUES(8,1,7,'M',1,'');
INSERT INTO om_chatroom_user VALUES(9,1,3,'M',1,'');
INSERT INTO om_chatroom_user VALUES(10,1,4,'M',1,'');
INSERT INTO om_chatroom_user VALUES(11,1,5,'M',1,'');
INSERT INTO om_chatroom_user VALUES(12,1,9,'M',1,'');
INSERT INTO om_chatroom_user VALUES(13,2,6,'M',1,'');
INSERT INTO om_chatroom_user VALUES(14,2,5,'M',1,'');
CREATE TABLE [om_settings] (
                [settings_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                [type] NVARCHAR(100),
                [value] NVARCHAR(100),
                [big_value] NTEXT
                );
INSERT INTO om_settings VALUES(1,'DeviceID','1caa6c3dd3890b89242d333178dfce9f575d5784',NULL);
INSERT INTO om_settings VALUES(2,'email','martinez@infiltrator.htb',NULL);
INSERT INTO om_settings VALUES(3,'phone','',NULL);
INSERT INTO om_settings VALUES(4,'UserTitle','Chief Marketing Officer',NULL);
INSERT INTO om_settings VALUES(5,'chkIdle','True',NULL);
INSERT INTO om_settings VALUES(6,'cboIdle','20',NULL);
INSERT INTO om_settings VALUES(7,'ServerLessCommunication','True',NULL);
INSERT INTO om_settings VALUES(8,'PreviousGroupChatMessage','False',NULL);
INSERT INTO om_settings VALUES(9,'UserUpdatedDate','2024-02-20T01:18:49',NULL);
INSERT INTO om_settings VALUES(10,'GroupUpdatedDate','1900-01-01T08:00:00',NULL);
INSERT INTO om_settings VALUES(11,'RefreshDate','1900-01-01T08:00:00',NULL);
INSERT INTO om_settings VALUES(12,'ServerVersion','2.0.42',NULL);
INSERT INTO om_settings VALUES(13,'LastSyncMessageID ','XE5CET2507195787',NULL);
INSERT INTO om_settings VALUES(14,'LastSyncActivityMessageID ','',NULL);
INSERT INTO om_settings VALUES(15,'ServerPlugins','','<?xml version="1.0" encoding="utf-8"?><OUM><Plugin><Name>Output Mail</Name></Plugin></OUM>');
INSERT INTO om_settings VALUES(16,'ReadMessageUpdatedDate','2024-02-25 15:20:08',NULL);
INSERT INTO om_settings VALUES(17,'CustomGroupUpdatedDate','1900-01-01T08:00:00',NULL);
INSERT INTO om_settings VALUES(18,'CustomGroupRefreshDate','1900-01-01T08:00:00',NULL);
INSERT INTO om_settings VALUES(19,'IPRange','2024-02-19T15:41:16.000Z','1||Local Network;2||Other Networks');
CREATE TABLE [om_preset_message] (
                  [presetmsg_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                  [presetmsg] NVARCHAR(200),
                  [shortcut] NVARCHAR(10),
                  [instantsend] NVARCHAR(5)
                  );
CREATE TABLE [om_drive_files] (
          [file_id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          [user_id] INTEGER,
          [room_key] NVARCHAR(100),
          [file_key] NVARCHAR(100),
          [file_name] NVARCHAR(200),
          [file_path] NVARCHAR(600),
          [modified_date] datetime,
          [file_size] INTEGER NULL,
          [version_key] NVARCHAR(100),
          [created_by] INTEGER,
          [last_access_date] datetime,
          [role] nvarchar(1) NULL,
          [remote_server_id] INTEGER,
          [created_by_name] NVARCHAR(100)
          );
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('om_settings',19);
INSERT INTO sqlite_sequence VALUES('om_user_master',12);
INSERT INTO sqlite_sequence VALUES('om_chatroom',2);
INSERT INTO sqlite_sequence VALUES('om_chatroom_user',14);
INSERT INTO sqlite_sequence VALUES('om_user_photo',6);
COMMIT;
