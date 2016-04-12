<?php

/**
 * Fired during plugin activation
 *
 * @link       http://example.com
 * @since      1.0
 *
 * @package    Kam
 * @subpackage Kam/includes
 */

/**
 * Fired during plugin activation.
 *
 * This class defines all code necessary to run during the plugin's activation.
 *
 * @since      1.0
 * @package    Kam
 * @subpackage Kam/includes
 * @author     Your Name <email@example.com>
 */
class Kam_Activator {
	/**
	 * Short Description. (use period)
	 *
	 * Long Description.
	 *
	 * @since    1.0
	 */
	 public static function activate() {

        $role = get_role('dprovider');
        if ( $role->name == "dprovider" ) {
            $blogusers = get_users('role=dprovider');
            add_role('provider', 'Provider', array(
                'read' => true, 
                'edit_posts' => true,
                'delete_posts' => false, 
            ));

            foreach ( $blogusers as $user ) { 
                $provider = new WP_User($user->ID);
                $provider->remove_role('dprovider');
                $provider->add_role('provider');
            }
            remove_role('dprovider');
        } else {
            add_role('provider', 'Provider', array(
                'read' => true, 
                'edit_posts' => true,
                'delete_posts' => false, 
            ));
        }
        $get_role_dparent = get_role('dparent');
        if ( $get_role_dparent->name == "dparent" ) {
            add_role('parent', 'Parent', array(
                'read' => true, 
            ));
            
            foreach ( $blogusers as $user ) {
                $parents = new WP_User($user->ID);
                $parents->remove_role('dparent');
                $parents->add_role('parent');
            }
            remove_role('dparent');
        } else {
            add_role('parent', 'Parent', array(
                'read' => true, 
            ));
        }
    }
}
