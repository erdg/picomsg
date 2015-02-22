#### The Nanomsg API ####

# this-is-a-function
# THIS_IS_A_VARIABLE
# _THIS_IS_A_HIDDEN_VARIABLE


(setq libnanomsg* "/usr/local/lib/libnanomsg.so")


### Constants ###
# There's an easier way to do this using nn_symbols, but I'm a n00b. 

(def 'NN_MSG -1)
(def 'NN_SOL_SOCKET 0)

## Generic Socket Options
(def 'NN_LINGER 1)
(def 'NN_SNDBUF 2)
(def 'NN_RCVBUF 3)
(def 'NN_SNDTIMEO 4)
(def 'NN_RCVTIMEO 5)
(def 'NN_RECONNECT_IVL 6)
(def 'NN_RECONNECT_IVL_MAX 7)
(def 'NN_SNDPRIO 8)
(def 'NN_RCVPRIO 9)
(def 'NN_SNDFD 10)
(def 'NN_RCVFD 11)
(def 'NN_DOMAIN 12)
(def 'NN_PROTOCOL 13)
(def 'NN_IPV4ONLY 14)
(def 'NN_SOCKET_NAME 15) 

## Transports
(def 'NN_INPROC -1)
(def 'NN_IPC -2)
(def 'NN_TCP -3)

## Socket Types
(def 'AF_SP 1)
(def 'AF_SP_RAW 2)



## Scalability Protocols

# Pair
(def '_NN_PROTO_PAIR 1)
(def 'NN_PAIR (+ (* _NN_PROTO_PAIR 16) 0))


# ReqRep
(def '_NN_PROTO_REQREP 3)
(def 'NN_REQ (+ (* _NN_PROTO_REQREP 16) 0))
(def 'NN_REP (+ (* _NN_PROTO_REQREP 16) 1))

(def 'NN_REQ_RESEND_IVL 1)


# PubSub
(def '_NN_PROTO_PUBSUB 2)
(def 'NN_PUB (+ (* _NN_PROTO_PUBSUB 16) 0))
(def 'NN_SUB (+ (* _NN_PROTO_PUBSUB 16) 1))

(def 'NN_SUB_SUBSCRIBE 1)
(def 'NN_SUB_UNSUBSCRIBE 2)


# Survey
(def '_NN_PROTO_SURVEY 6)
(def 'NN_SURVEYOR (+ (* _NN_PROTO_SURVEY 16) 0))
(def 'NN_RESPONDENT (+ (* _NN_PROTO_SURVEY 16) 1))

(def 'NN_SURVEYOR_DEADLINE 1)


# Pipeline 
(def '_NN_PROTO_PIPELINE 5)
(def 'NN_PUSH (+ (* _NN_PROTO_PIPELINE 16) 0))
(def 'NN_PULL (+ (* _NN_PROTO_PIPELINE 16) 1))


# Bus 
(def '_NN_PROTO_BUS 7)
(def 'NN_BUS (+ (* _NN_PROTO_BUS 16) 0))




(de nn-socket (PROTO) 
   (native `libnanomsg* "nn_socket" 'I `AF_SP PROTO) )

(de nn-socket-raw (PROTO)
   (native `libnanomsg* "nn_socket" 'I `AF_SP_RAW PROTO) )

(de nn-close (SOCK) 
   (native `libnanomsg* "nn_close" 'I SOCK) )

(de nn-setsockopt (SOCK LVL OPT OPT_VAL OPT_VAL_LEN)
   (native `libnanomsg* "nn_setsockopt" 'I SOCK LVL OPT OPT_VAL OPT_VAL_LEN) )

(de nn-getsockopt (SOCK LVL OPT OPT_VAL OPT_VAL_LEN)
   (native `libnanomsg* "nn_getsockopt" 'I SOCK LVL OPT OPT_VAL OPT_VAL_LEN) )


(de nn-bind (SOCK ADDR)
   (native `libnanomsg* "nn_bind" 'I SOCK ADDR) )

(de nn-connect (SOCK ADDR)
   (native `libnanomsg* "nn_connect" 'I SOCK ADDR) )

(de nn-shutdown (SOCK ID)
   (native `libnanomsg* "nn_shutdown" SOCK ID) )



(de nn-send (SOCK BUF LEN FLAGS)
   (native `libnanomsg* "nn_send" 'I SOCK BUF LEN FLAGS) )

(de nn-sendmsg ())

(de nn-recv (SOCK BUF LEN FLAGS)
   (native `libnanomsg* "nn_recv" 'I SOCK BUF LEN FLAGS) )

(de nn-recvmsg ())



(de nn-allocmsg (SIZE TYPE)
   (native `libnanomsg* "nn_allocmsg" NIL SIZE TYPE) )

(de nn-reallocmsg ())

(de nn-freemsg (MSG)
   (native `libnanomsg* "nn_freemsg" 'I MSG) )



(de nn-strerror (NUM) # Error Number
   (native `libnanomsg* "nn_strerror" 'S NUM) )



### Unit Tests ###
(de nanomsg-tests ()
   ~(assert (>= (nn-socket NN_PAIR) 0))
   ~(assert (>= (nn-socket NN_REQ) 0))
   ~(assert (>= (nn-socket NN_REP) 0))
   ~(assert (>= (nn-socket NN_PUB) 0))
   ~(assert (>= (nn-socket NN_SUB) 0))
   ~(assert (>= (nn-socket NN_SURVEYOR) 0))
   ~(assert (>= (nn-socket NN_RESPONDENT) 0))
   ~(assert (>= (nn-socket NN_PUSH) 0))
   ~(assert (>= (nn-socket NN_PULL) 0))
   ~(assert (>= (nn-socket NN_BUS) 0))
   (println "All systems go") )

(nanomsg-tests)
