with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with System;

package ZMQ.Low_Level is

   package defs is

      ZMQ_HAUSNUMERO : constant := 156384712;  --  zmq.h:48
      EMTHREAD       : constant := ZMQ_HAUSNUMERO + 50;
      EFSM           : constant := ZMQ_HAUSNUMERO + 51;
      ENOCOMPATPROTO : constant := ZMQ_HAUSNUMERO + 52;

      ZMQ_MAX_VSM_SIZE : constant := 30;  --  zmq.h:92

      ZMQ_DELIMITER  : constant := 31;  --  zmq.h:96
      ZMQ_VSM        : constant := 32;  --  zmq.h:97

      ZMQ_POLL       : constant := 1;  --  zmq.h:128

      ZMQ_P2P        : constant := 0;  --  zmq.h:150
      ZMQ_PUB        : constant := 1;  --  zmq.h:151
      ZMQ_SUB        : constant := 2;  --  zmq.h:152
      ZMQ_REQ        : constant := 3;  --  zmq.h:153
      ZMQ_REP        : constant := 4;  --  zmq.h:154
      ZMQ_XREQ       : constant := 5;  --  zmq.h:155
      ZMQ_XREP       : constant := 6;  --  zmq.h:156
      ZMQ_UPSTREAM   : constant := 7;  --  zmq.h:157
      ZMQ_DOWNSTREAM : constant := 8;  --  zmq.h:158

      ZMQ_HWM        : constant := 1;  --  zmq.h:160
      ZMQ_LWM        : constant := 2;  --  zmq.h:161
      ZMQ_SWAP       : constant := 3;  --  zmq.h:162
      ZMQ_AFFINITY   : constant := 4;  --  zmq.h:163
      ZMQ_IDENTITY   : constant := 5;  --  zmq.h:164
      ZMQ_SUBSCRIBE  : constant := 6;  --  zmq.h:165
      ZMQ_UNSUBSCRIBE : constant := 7;  --  zmq.h:166
      ZMQ_RATE       : constant := 8;  --  zmq.h:167
      ZMQ_RECOVERY_IVL : constant := 9;  --  zmq.h:168
      ZMQ_MCAST_LOOP : constant := 10;  --  zmq.h:169
      ZMQ_SNDBUF     : constant := 11;  --  zmq.h:170
      ZMQ_RCVBUF     : constant := 12;  --  zmq.h:171

      ZMQ_NOBLOCK    : constant := 1;  --  zmq.h:173
      ZMQ_NOFLUSH    : constant := 2;  --  zmq.h:174

      ZMQ_POLLIN     : constant := 1;  --  zmq.h:190
      ZMQ_POLLOUT    : constant := 2;  --  zmq.h:191
   end defs;

   function zmq_strerror (errnum : int) return Interfaces.C.Strings.chars_ptr;  -- zmq.h:82:48
   pragma Import (C, zmq_strerror, "zmq_strerror");

   type zmq_msg_t_vsm_data_array is array (0 .. 29) of aliased unsigned_char;
   type zmq_msg_t is record
      content  : System.Address;  -- zmq.h:106:11
      shared   : aliased unsigned_char;  -- zmq.h:107:19
      vsm_size : aliased unsigned_char;  -- zmq.h:108:19
      vsm_data : aliased zmq_msg_t_vsm_data_array;  -- zmq.h:109:45
   end record;
   pragma Convention (C_Pass_By_Copy, zmq_msg_t);  -- zmq.h:110:3

   --  skipped anonymous struct anon_0

   --  skipped function type zmq_free_fn

   function zmq_msg_init (msg : access zmq_msg_t) return int;  -- zmq.h:114:44
   pragma Import (C, zmq_msg_init, "zmq_msg_init");

   function zmq_msg_init_size (msg : access zmq_msg_t; size : Natural) return int;  -- zmq.h:115:62
   pragma Import (C, zmq_msg_init_size, "zmq_msg_init_size");

   function zmq_msg_init_data
     (msg  : access zmq_msg_t;
      data : System.Address;
      size : Natural;
      ffn  : access procedure (arg1 : System.Address; arg2 : System.Address);
      hint : System.Address) return int;  -- zmq.h:117:46
   pragma Import (C, zmq_msg_init_data, "zmq_msg_init_data");

   function zmq_msg_close (msg : access zmq_msg_t) return int;  -- zmq.h:118:45
   pragma Import (C, zmq_msg_close, "zmq_msg_close");

   function zmq_msg_move (dest : access zmq_msg_t; src : access zmq_msg_t) return int;  -- zmq.h:119:61
   pragma Import (C, zmq_msg_move, "zmq_msg_move");

   function zmq_msg_copy (dest : access zmq_msg_t; src : access zmq_msg_t) return int;  -- zmq.h:120:61
   pragma Import (C, zmq_msg_copy, "zmq_msg_copy");

   function zmq_msg_data (msg : access zmq_msg_t) return System.Address;  -- zmq.h:121:46
   pragma Import (C, zmq_msg_data, "zmq_msg_data");

   function zmq_msg_size (msg : access zmq_msg_t) return Natural;  -- zmq.h:122:47
   pragma Import (C, zmq_msg_size, "zmq_msg_size");

   function zmq_init
     (app_threads : int;
      io_threads  : int;
      flags       : int) return System.Address;  -- zmq.h:130:70
   pragma Import (C, zmq_init, "zmq_init");

   function zmq_term (context : System.Address) return int;  -- zmq.h:131:39
   pragma Import (C, zmq_term, "zmq_term");

   function zmq_socket (context : System.Address; c_type : int) return System.Address;  -- zmq.h:176:53
   pragma Import (C, zmq_socket, "zmq_socket");

   function zmq_close (s : System.Address) return int;  -- zmq.h:177:34
   pragma Import (C, zmq_close, "zmq_close");

   function zmq_setsockopt
     (s         : System.Address;
      option    : int;
      optval    : System.Address;
      optvallen : Natural) return int;  -- zmq.h:179:21
   pragma Import (C, zmq_setsockopt, "zmq_setsockopt");

   function zmq_bind (s : System.Address; addr : Interfaces.C.Strings.chars_ptr) return int;  -- zmq.h:180:51
   pragma Import (C, zmq_bind, "zmq_bind");

   function zmq_connect (s : System.Address; addr : Interfaces.C.Strings.chars_ptr) return int;  -- zmq.h:181:54
   pragma Import (C, zmq_connect, "zmq_connect");

   function zmq_send
     (s     : System.Address;
      msg   : access zmq_msg_t;
      flags : int) return int;  -- zmq.h:182:60
   pragma Import (C, zmq_send, "zmq_send");

   function zmq_flush (s : System.Address) return int;  -- zmq.h:183:34
   pragma Import (C, zmq_flush, "zmq_flush");

   function zmq_recv
     (s     : System.Address;
      msg   : access zmq_msg_t;
      flags : int) return int;  -- zmq.h:184:60
   pragma Import (C, zmq_recv, "zmq_recv");

   type zmq_pollitem_t is record
      socket  : System.Address;  -- zmq.h:195:11
      fd      : aliased int;  -- zmq.h:199:9
      events  : aliased short;  -- zmq.h:201:11
      revents : aliased short;  -- zmq.h:202:11
   end record;
   pragma Convention (C_Pass_By_Copy, zmq_pollitem_t);  -- zmq.h:203:3

   --  skipped anonymous struct anon_1

   function zmq_poll
     (items   : access zmq_pollitem_t;
      nitems  : int;
      timeout : long) return int;  -- zmq.h:205:73
   pragma Import (C, zmq_poll, "zmq_poll");

   function zmq_stopwatch_start return System.Address;  -- zmq.h:215:39
   pragma Import (C, zmq_stopwatch_start, "zmq_stopwatch_start");

   function zmq_stopwatch_stop (watch_u : System.Address) return unsigned_long;  -- zmq.h:219:58
   pragma Import (C, zmq_stopwatch_stop, "zmq_stopwatch_stop");

   procedure zmq_sleep (seconds_u : int);  -- zmq.h:222:40
   pragma Import (C, zmq_sleep, "zmq_sleep");

end ZMQ.Low_Level;