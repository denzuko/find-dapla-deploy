(:repo-name    'find-dapla-deploy'
 :system-name  'find-dapla-deploy'
 :fqdn         'find.dapla.net'
 :vhost-name   'find'
 :service-user 'searxng'
 :description  'SearXNG metasearch engine'
 :image        'oci.dapla.net/searxng/searxng:latest'
 :internal-port 8080
 :health-path  '/healthz'
 :datasets
 (  (:name 'users/searxng'
   :mountpoint '/var/lib/searxng'
   :purpose 'Service account home directory')
  (:name 'containers/searxng'
   :mountpoint '/srv/searxng'
   :purpose 'SearXNG settings and data'))
)
