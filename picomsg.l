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

# what exactly are we keeping track of?

(class +Node +Entity)
   (rel nm) # name prefix
   (rel typ) # pub, sub, bus, etc.
   (rel binds) # local endpoints
   (rel ends) # remote endpoints
   (rel opts) # socket options
