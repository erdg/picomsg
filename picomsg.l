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
      (nn-recv SOCK '(_BUF (24 C . 24) . 0) 24 0)
      (prinl _BUF) ) )



# Socket Options

(de pm-setsockopt (SOCK LVL OPT NAME)
   (nn-setsockopt SOCK LVL OPT NAME (length NAME)) )



### Database ###
# none of this works... yet. 

(class +Socket +Entity)
   (rel nu    (+Number))     # number, maybe the fd returned by nn-socket?
   (rel name  (+String))
   (rel type  (+String))     # pub, sub, pair, etc. probably not necessary.
   (rel binds (+List +Bind)) # local endpoints
   (rel ends  (+List +End))  # remote endpoints
   (rel log ()) # life story of socket. a memoir. history. fully searchable.

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
(dm close> ())
(dm bind> ())
(dm connect> ())
(dm send> ())
(dm recv> ())



# necessary? probably not; but it's great fun to make classes.
(class +Connection +Entity)
   (rel proto (+String)) # transport protocol 
   (rel addr (+String))  # address

(dm shutdown> ())

(class +Bind +Connection)
   (rel socks (+List +Socket))

(class +End +Connection
   (rel socks (+List +Socket))


# pair 
(class +Pair +Socket)


# req/rep
(class +Req +Socket)
   (rel resend_ivl (+Number)) # resend interval

(class +Rep +Socket)



# pub/sub
(class +Pub +Socket)


(class +Sub +Socket)
   (rel subs (+List +Subscription)) 

(dm subscribe> (SOCK STR)
   (nn-setsockopt SOCK NN_SUB NN_SUB_SUBSCRIBE STR (length STR)) )

(dm unsubscribe> (SOCK STR)
   (nn-setsockopt SOCK NN_SUB NN_SUB_UNSUBSCRIBE STR (length STR)) )


(class +Subscription +Entity)
   (rel name (+String))
   (rel subs (+List +Sub)



# survey
(class +Surveyor +Socket)
   (rel surv_deadline (+Number)) # ms

(class +Respondent +Socket)


# pipeline
(class +Push +Socket)

(class +Pull +Socket)


# bus
(class +Bus +Socket)
