DNS stands for Domain Name System. It is a hierarchical and decentralized naming system for computers, services, or other resources connected to the Internet or a private network.

DNS maps human-readable domain names, such as "[www.example.com](http://www.example.com/)", to machine-readable IP addresses, such as "192.0.2.1". This mapping allows users to access Internet resources using easily remembered domain names instead of having to remember and manually enter IP addresses.

DNS is an essential component of the Internet infrastructure and is responsible for translating domain names into IP addresses, providing information about email servers, and other tasks. The DNS system is decentralized, meaning that no single entity is responsible for maintaining the entire DNS database. Instead, the database is distributed among a large number of DNS servers, each of which is responsible for a portion of the database.

DNS operates on the client-server model, where clients send DNS queries to DNS servers and receive responses with the requested information. The DNS system also uses a cache mechanism, where the results of previous queries are stored locally, to speed up subsequent queries and reduce network traffic.

First, your operating system checks whether it already knows the IP address for "www.example.com" . If you have used that hostname recently, the OS is allowed to remember it in a local cache for a time. This time is referred to as time-to-live (TTL) and is set by the DNS server responsible for the hostname.

If the hostname is not found in the local cache, then your operating system will need to query a DNS server. This DNS server is usually provided by your Internet Service Provider (ISP), but there are also many publicly-available DNS servers. When the DNS server receives a query, it also checks its local cache.

If the DNS server doesn't have the requested DNS record in its cache, then it needs to query other DNS servers until it connects directly to the DNS server responsible for the target system

## DNS record types

There are several types of DNS records that are used to store different types of information about a domain name in the DNS system. Some of the most commonly used DNS record types are:

1.  A (Address) record: Maps a domain name to an IPv4 address, such as "[www.example.com](http://www.example.com/)" to "192.0.2.1".
    
2.  AAAA (IPv6 Address) record: Maps a domain name to an IPv6 address, such as "[www.example.com](http://www.example.com/)" to "2001:db8::1".
    
3.  MX (Mail Exchange) record: Specifies the mail server responsible for receiving email for a domain, such as "example.com".
    
4.  CNAME (Canonical Name) record: Specifies an alias for a domain name, such as "[www.example.com](http://www.example.com/)" being an alias for "example.com".
    
5.  NS (Name Server) record: Specifies the authoritative name servers for a domain, such as "ns1.example.com" and "ns2.example.com".
    
6.  TXT (Text) record: Can be used to store arbitrary text information about a domain, such as SPF (Sender Policy Framework) or DKIM (DomainKeys Identified Mail) records.
    
7.  SRV (Service) record: Used to specify the location of a service, such as a SIP or XMPP server.
	
8. * or ALL or ANY: When doing a DNS query, there is also a pseudo-record type called * or ALL or ANY. If this record is requested from a DNS server, then the DNS server returns all known record types for the current query. Note that a DNS server is allowed to respond with only the records in its cache, and this query is not guaranteed (or even likely) to actually get all of the records for the requested domain.

Each DNS record has specific fields that contain information about the domain name, such as the name of the record, the time-to-live (TTL), and the priority. The information stored in these records is used by the DNS system to direct traffic and provide information about Internet resources.

It should be noted that one hostname may be associated with multiple records of the same type. For example, example.com could have several A records, each with a different IPv4 address. This is useful if multiple servers can provide the same service.

## DNS security

What are the implications of using insecure DNS? First, if DNS is not authenticated, then it could allow an attacker to lie about a domain name's IP address. This could trick a victim into connecting to a server that they think is example.com, but, in reality, is a malicious server controlled by the attacker at a different IP address. If the user is connecting via a secure protocol, such as HTTPS, then this attack will fail. HTTPS provides additional authentication to prove server identity. However, if the user connects with an insecure protocol, such as HTTP, then the DNS attack could successfully trick the victim into connecting to the wrong server.

*Domain Name System Security Extensions (DNSSEC)* are DNS extensions that provide data authentication. This authentication allows a DNS client to know that a given DNS reply is authentic, but it does not protect against eavesdropping (Eavesdropping refers to the unauthorized listening or interception of private communications).

*DNS over HTTPS (DoH)* is a protocol that provides name resolution over HTTPS. HTTPS provides strong security guarantees, including resistance to interception. We cover HTTPS in Chapter 9, Loading Secure Web Pages with HTTPS and OpenSSL, and Chapter 10, Implementing a Secure Web Server.

[[struct addrinfo]] and [[getaddrinfo]]