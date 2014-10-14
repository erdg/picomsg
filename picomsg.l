#### PicoMsg ####
# PicoLisp Extensions to NanoMsg

(load "nanomsg.l")

# this-is-a-function
# THIS_IS_A_VARIABLE
# _THIS_IS_A_HIDDEN_VARIABLE 

(de pm-socket (PROTO) 
   (nn-socket PROTO) )

(de pm-socket-raw (PROTO)
   (nn-socket-raw PROTO) )

# Pair
(de pm-pair ()
   (nn-socket NN_PAIR) )

(de pm-pair-raw ()
   (nn-socket-raw NN_PAIR) )


# Bus
(de pm-bus ()
   (nn-socket NN_BUS) )

(de pm-bus-raw ()
   (nn-socket-raw NN_BUS) )


# Survey
(de pm-surv ()
   (nn-socket NN_SURVEYOR) )

(de pm-surv-raw ()
   (nn-socket-raw NN_SURVEYOR) )

(de pm-resp ()
   (nn-socket NN_RESPONDENT) )

(de pm-resp-raw ()
   (nn-socket-raw NN_RESPONDENT) )


# Pipeline
(de pm-push ()
   (nn-socket NN_PUSH) )

(de pm-push-raw ()
   (nn-socket-raw NN_PUSH) )

(de pm-pull ()
   (nn-socket NN_PULL) )

(de pm-pull-raw ()
   (nn-socket-raw NN_PULL) )




# Pub/Sub
(de pm-pub ()
   (nn-socket NN_PUB) )

(de pm-pub-raw ()
   (nn-socket-raw NN_SUB) )

(de pm-sub ()
   (nn-socket NN_SUB) )

(de pm-sub-raw ()
   (nn-socket-raw NN_SUB) )



# Req/Rep

(de pm-req ()
   (nn-socket NN_REQ) )

(de pm-req-raw ()
   (nn-socket-raw NN_REQ) )

(de pm-rep ()
   (nn-socket NN_REP) )

(de pm-rep-raw ()
   (nn-socket-raw NN_REP) )



# Messaging

(de pm-recv (SOCK BUF LEN FLAGS))
(de pm-send (SOCK BUF LEN FLAGS))

(de pm-send-str (SOCK STR)
   (nn-send SOCK STR (length STR) 0) )

(de pm-recv-str (SOCK) # Socket
   (prog1
      (nn-recv SOCK '(_BUF (256 C . 256) . 0) 256 0)
      (prinl _BUF) ) )



# Socket Options

(de pm-setsockopt (SOCK LVL OPT NAME)
   (nn-setsockopt SOCK LVL OPT NAME (length NAME)) )



### Database ###
# none of this works... yet. 

(class +Socket +Entity)
   (rel num   (+Number))     # number, maybe the fd returned by nn-socket?
   (rel name  (+String))
   (rel type  (+String))     # AF_SP or AF_SP_RAW
   (rel binds (+List +Bind)) # local endpoints
   (rel ends  (+List +End))  # remote endpoints
   (rel log   ()) # life story of socket. a memoir. history. fully searchable.

   # NN_SOL_SOCKET options
   (rel linger            (+Number))     
   (rel send_buffer       (+Number))
   (rel receive_buffer    (+Number))
   (rel send_timeout      (+Number))
   (rel receive_timeout   (+Number))
   (rel reconnect_ivl     (+Number))
   (rel reconnect_ivl_max (+Number))
   (rel send_priority     (+Number))
   (rel receive_priority  (+Number))
   (rel ipv4_only         (+Number))


(dm open> ())

(dm close> (SOCK)
   (nn-close SOCK) )

(dm bind> (ADDR)
   (nn-bind This ADDR) )

(dm connect> (ADDR)
   (nn-connect This ADDR) )

(dm shutdown> (ID)
   (nn-shutdown This ID) )

(dm send> ())
(dm send-str> ())
(dm send-osc> ())
(dm send-coap> ())

(dm recv> ())
(dm recv-str> ())
(dm recv-osc> ())
(dm recv-coap> ())



# messages
(class +Msg +Entity)
   (rel num (+Number))
   (rel stamp ()) # time/date 
   (rel size (+Number))
   (rel data (+Blob))

(class +Pub_Msg +Msg)
   (rel key (+String))  # subscription key

(class +Osc_Msg ())
(class +Coap_Msg ())



# binds/connects
(class +Endpoint +Entity)
   (rel num   (+Number))
   (rel proto (+String)) # transport protocol 
   (rel addr  (+String))  # address

(dm shutdown> (SOCK)
   (nn-shutdown SOCK This) )

(class +Local_Endpoint +Endpoint)
   (rel socks (+List +Socket))

(class +Remote_Endpoint +Endpoint)
   (rel socks (+List +Socket))



## protocols

# pair 
(class +Pair +Socket)

(dm open> ()
   (nn-socket NN_PAIR) )



# req/rep
(class +Req +Socket)
   (rel resend_ivl (+Number)) # resend interval

(dm open> ()
   (nn-socket NN_REQ) )


(class +Rep +Socket)

(dm open> ()
   (nn-socket NN_REP) )

# pub/sub
(class +Pub +Socket)

(dm open> ()
   (nn-socket NN_PUB) )


(class +Sub +Socket)
   (rel subs (+List +Subscription)) 

(dm open> ()
   (nn-socket NN_SUB) )

(dm subscribe> (SOCK STR)
   (nn-setsockopt SOCK NN_SUB NN_SUB_SUBSCRIBE STR (length STR)) )

(dm unsubscribe> (SOCK STR)
   (nn-setsockopt SOCK NN_SUB NN_SUB_UNSUBSCRIBE STR (length STR)) )


(class +Subscription +Entity)
   (rel name (+String))
   (rel subs (+List +Sub)

(dm close> ()) # Removes the +Subscription from all subscribed +Socket's



# survey
(class +Surveyor +Socket)
   (rel surv_deadline (+Number)) # ms

(dm open> () 
   (nn-socket NN_SURVEYOR) )



(class +Respondent +Socket)

(dm open> ()
   (nn-socket NN_RESPONDENT) )



# pipeline
(class +Push +Socket)

(dm open> ()
   (nn-socket NN_PUSH) )


(class +Pull +Socket)

(dm open> ()
   (nn-socket NN_PULL) )



# bus
(class +Bus +Socket)

(dm open> ()
   (nn-socket NN_BUS) )
