<?php

/**
 * Fired during plugin deactivation
 *
 * @link       http://example.com
 * @since      1.0
 *
 * @package    Kam
 * @subpackage Kam/includes
 */

/**
 * Fired during plugin deactivation.
 *
 * This class defines all code necessary to run during the plugin's deactivation.
 *
 * @since      1.0
 * @package    Kam
 * @subpackage Kam/includes
 * @author     Your Name <email@example.com>
 */
class Kam_Deactivator {
	/**
	 * Short Description. (use period)
	 *
	 * Long Description.
	 *
	 * @since    1.0
	 */
	 public static function deactivate() {

        $blogusers = get_users('role=provider');


        foreach ( $blogusers as $user ) {

            $provider = new WP_User( $user->ID );
            $provider->remove_role('provider');
            add_role('dprovider', 'Deactive Provider', array(
                'read' => true, 
            ));
            $provider->add_role('dprovider');
            $provider->remove_role('provider');
        }
        
        $blogparent = get_users('role=parent');
        foreach ( $blogparent as $parentuser ) {
            $parents = new WP_User( $user->ID );
            $parents->remove_role('parent');
            add_role('dparent', 'Deactive Parent', array(
                'read' => true,
            ));
            $parents->add_role('dparent');
            $provider->remove_role('parent');
        }
        remove_role('provider');
        remove_role('parent');
    }
}
