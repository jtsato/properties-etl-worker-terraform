import yaml
import os

def save_yaml(data, file_path):
    with open(file_path, 'w') as file:
        yaml.safe_dump(data, file, default_flow_style=False)

def modify_docker_compose(data, changes):
    for service, values in changes.items():
        if service in data['services']:
            data['services'][service].update(values)
        else:
            data['services'][service] = values
    return data

file_path = 'docker-compose.yml'

service_name = os.getenv('SERVICE_NAME')
image_url = os.getenv('IMAGE_URL')
log_level = os.getenv('LOG_LEVEL')
ai_prompt = os.getenv('AI_PROMPT')
t1_search_properties_url = os.getenv('T1_SEARCH_PROPERTIES_URL')
t1_imgs_pattern_prefix_url = os.getenv('T1_IMGS_PATTERN_PREFIX_URL')
t1_load_timeout_in_seconds = os.getenv('T1_LOAD_TIMEOUT_IN_SECONDS')
t1_xpath_timeout_in_seconds = os.getenv('T1_XPATH_TIMEOUT_IN_SECONDS')
cloudamqp_url = os.getenv('CLOUDAMQP_URL')
openai_api_key = os.getenv('OPENAI_API_KEY')
perplexity_api_key = os.getenv('PERPLEXITY_API_KEY')
mongodb_url = os.getenv('MONGODB_URL')
mongodb_database = os.getenv('MONGODB_DATABASE')
mongodb_user = os.getenv('MONGODB_USER')
mongodb_password = os.getenv('MONGODB_PASSWORD')
property_collection_name = os.getenv('PROPERTY_COLLECTION_NAME')
bucket_name = os.getenv('BUCKET_NAME')

if not service_name:
    raise ValueError('SERVICE_NAME is required')
if not image_url:
    raise ValueError('IMAGE_URL is required')
if not log_level:
    raise ValueError('LOG_LEVEL is required')
if not ai_prompt:
    raise ValueError('AI_PROMPT is required')
if not t1_search_properties_url:
    raise ValueError('T1_SEARCH_PROPERTIES_URL is required')
if not t1_imgs_pattern_prefix_url:
    raise ValueError('T1_IMGS_PATTERN_PREFIX_URL is required')
if not t1_load_timeout_in_seconds:
    raise ValueError('T1_LOAD_TIMEOUT_IN_SECONDS is required')
if not t1_xpath_timeout_in_seconds:
    raise ValueError('T1_XPATH_TIMEOUT_IN_SECONDS is required')
if not cloudamqp_url:
    raise ValueError('CLOUDAMQP_URL is required')
if not openai_api_key:
    raise ValueError('OPENAI_API_KEY is required')
if not perplexity_api_key:
    raise ValueError('PERPLEXITY_API_KEY is required')
if not mongodb_url:
    raise ValueError('MONGODB_URL is required')
if not mongodb_database:
    raise ValueError('MONGODB_DATABASE is required')
if not mongodb_user:
    raise ValueError('MONGODB_USER is required')
if not mongodb_password:
    raise ValueError('MONGODB_PASSWORD is required')
if not property_collection_name:
    raise ValueError('PROPERTY_COLLECTION_NAME is required')
if not bucket_name:
    raise ValueError('BUCKET_NAME is required')

changes = {
    service_name : {
        'image': image_url,
        'environment': {
            'LOG_LEVEL': log_level,
            'AI_PROMPT': ai_prompt,
            'T1_SEARCH_PROPERTIES_URL': t1_search_properties_url,
            'T1_IMGS_PATTERN_PREFIX_URL': t1_imgs_pattern_prefix_url,
            'T1_LOAD_TIMEOUT_IN_SECONDS': t1_load_timeout_in_seconds,
            'T1_XPATH_TIMEOUT_IN_SECONDS': t1_xpath_timeout_in_seconds,
            'BUCKET_NAME': bucket_name,
            'CLOUDAMQP_URL': cloudamqp_url,
            'OPENAI_API_KEY': openai_api_key,
            'PERPLEXITY_API_KEY': perplexity_api_key,
            'MONGODB_URL': mongodb_url,
            'MONGODB_DATABASE': mongodb_database,
            'MONGODB_USER': mongodb_user,
            'MONGODB_PASSWORD': mongodb_password,
            'PROPERTY_COLLECTION_NAME': property_collection_name,
            'GOOGLE_APPLICATION_CREDENTIALS': 'google-credentials.json',
            'TZ': 'America/Sao_Paulo' 
        },
        'volumes': [
            './google-credentials.json:/aracne/app/google-credentials.json'
        ]
    }
}

data = {
    "services": {
    }
}

modified_data = modify_docker_compose(data, changes)

save_yaml(modified_data, file_path)

print("docker-compose.yml file updated successfully")
